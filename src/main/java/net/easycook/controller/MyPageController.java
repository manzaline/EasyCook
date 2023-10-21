package net.easycook.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.MemberService;
import net.easycook.service.RecipeBoardService;
import net.easycook.vo.MemberVO;
import net.easycook.vo.RecipeBoardCommentVO;
import net.easycook.vo.RecipeBoardVO;
import pwdconv.PwdChange;

@Controller
public class MyPageController {
	
	@Autowired
	private MemberService memberService;
	
	@Autowired
	private RecipeBoardService recipeBoardService;

	@RequestMapping("/mypage_view")
	public String mypage_view(HttpServletRequest request,Model m) {
		int page=1;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		
		m.addAttribute("page",page);		
		return "MyPage/mypage_view";
	}
	
	@RequestMapping("/mypage")
	public ModelAndView mypage() {
		ModelAndView mp=new ModelAndView();
		mp.setViewName("MyPage/mypage");
		return mp;
	}
	
	@RequestMapping("/mp_recipe_list")
	public ModelAndView mp_recipe_list(HttpSession session, HttpServletRequest req) {
		ModelAndView mp=new ModelAndView();
		RecipeBoardVO rb = new RecipeBoardVO();
		
		String id = (String) session.getAttribute("id");
		int page = 1;
		if(req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		rb.setWriterid(id);
		
		//검색어 지정
		String searchText = "";
		if(req.getParameter("searchText") != null) {
			searchText = req.getParameter("searchText");
		}
		searchText = "%"+searchText+"%";
		rb.setSearchText(searchText);

		int totalPostings = recipeBoardService.getTotalPostingsById(rb);
		
		rb.setStartNum(page*10-9);
		rb.setEndNum(page*10);
		
		List<RecipeBoardVO> rbList = recipeBoardService.getPostingListById(rb);

		mp.addObject("totalPostings", totalPostings);
		mp.addObject("page", page);
		mp.addObject("rbList", rbList);
		searchText = searchText.replace("%", "");
		mp.addObject("searchText", searchText);
		mp.setViewName("MyPage/mp_recipe_list");
		return mp;
	}
	
	@RequestMapping("/mp_comment_list")
	public ModelAndView mp_comment_list(HttpSession session, HttpServletRequest req) {
		ModelAndView mp=new ModelAndView();
		RecipeBoardCommentVO rbc = new RecipeBoardCommentVO();

		String id = (String) session.getAttribute("id");
		int page = 1;
		if(req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		rbc.setCwriterid(id);
		
		//검색어 지정
		String searchText = "";
		if(req.getParameter("searchText") != null) {
			searchText = req.getParameter("searchText");
		}
		searchText = "%"+searchText+"%";
		rbc.setSearchText(searchText);
		
		int totalComments = recipeBoardService.getTotalCommentsById(rbc);

		rbc.setStartNum(page*10-9);
		rbc.setEndNum(page*10);
		
		List<RecipeBoardCommentVO> rbcList = recipeBoardService.getCommentListById(rbc);

		mp.addObject("totalComments", totalComments);
		mp.addObject("page", page);
		mp.addObject("rbcList", rbcList);
		searchText = searchText.replace("%", "");
		mp.addObject("searchText", searchText);
		mp.setViewName("MyPage/mp_comment_list");
		return mp;
	}

/*------------------정보수정-------------------------------*/
@GetMapping("/member_edit") //get으로 접근하는 매핑주소를 처리
public ModelAndView member_edit(HttpServletResponse response,HttpSession session) throws Exception{
    response.setContentType("text/html;charset=UTF-8");
    PrintWriter out=response.getWriter();
    
    String id=(String)session.getAttribute("id");//세션 아이디를 구함
    
    if(id == null) {
    	out.println("<script>");
    	out.println("alert('다시 로그인 하세요!');");
    	out.println("location='mypage_view';");
    	out.println("</script>");
    }else {
    	String[] email= {"naver.com","daum.net","nate.com","google.com","직접입력"};
		String[] pwdQ= {"어머니의 성함은?", "아버지의 성함은?", "나의 출신 초등학교는?"};

    	MemberVO m=this.memberService.getMember(id);//회원정보를 디비로 부터 가져옴.

    	
    	ModelAndView em=new ModelAndView("MyPage/member_edit");//생성자 인자값으로 뷰페이지 경로 설정
    	em.addObject("m",m);
    	em.addObject("email",email);
    	em.addObject("pwdQ",pwdQ);
    	return em;
    }
	return null;
}//member_edit()


//정보수정 완료
@RequestMapping("/member_edit_ok")
public String member_edit_ok(HttpServletResponse response,HttpSession session,MemberVO m) throws Exception{
	response.setContentType("text/html;charset=UTF-8");
	PrintWriter out=response.getWriter();
	
	String id=(String)session.getAttribute("id");
	
	if(id == null) {
		out.println("<script>");
		out.println("alert('다시 로그인 하세요!');");
		out.println("location='member_login';");
		out.println("</script>");
	}else {
		m.setJoin_id_box(id);
        m.setJoin_pw_box(PwdChange.getPassWordToXEMD5String(m.getJoin_pw_box()));//정식 비번을 암호화 해서 저장
        	        
        this.memberService.editMember(m);//정보 수정
        
        out.println("<script>");
        out.println("alert('회원 정보 수정했습니다!');");
        out.println("location='member_edit';");
        out.println("</script>");
        
	}
	return "MyPage/mypage_view";
}//member_edit_ok()
		

@RequestMapping("/member_del")
public ModelAndView member_del(HttpServletResponse response,HttpSession session) throws Exception{
	response.setContentType("text/html;charset=UTF-8");
	PrintWriter out=response.getWriter();
	
	String id=(String)session.getAttribute("id");
	
	if(id==null) {
		out.println("<script>");
		out.println("alert('다시 로그인 하세요!');");
		out.println("location='member_login';");
		out.println("</script>");
	}else {
		MemberVO m=this.memberService.getMember(id);
		ModelAndView dm=new ModelAndView();
		dm.setViewName("MyPage/member_del");//뷰페이지 경로 설정
		dm.addObject("m",m);
		return dm;
	}
	return null;
}

//회원탈퇴 완료
	@PostMapping("/member_del_ok")
	public String member_del_ok(String del_pwd, String del_cont,HttpServletResponse response,HttpSession session) throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		
		String id=(String)session.getAttribute("id");
		
		if(id== null) {
			out.println("<script>");
			out.println("alert('다시 로그인 하세요!');");
			out.println("location='member_login';");
			out.println("</script>");
		}else {
			del_pwd=PwdChange.getPassWordToXEMD5String(del_pwd);//비번을 암호화
			MemberVO db_pwd=this.memberService.getMember(id);
			
			if(db_pwd.getJoin_pw_box().equals(del_pwd)) {
				out.println("<script>");
				out.println("alert('비번이 다릅니다!');");
				out.println("history.back();");
				out.println("</script>");
			}else {
				MemberVO dm=new MemberVO();
				dm.setJoin_id_box(id); dm.setJoin_delcont(del_cont);
				this.memberService.delMem(dm);//회원탈퇴
				
				session.invalidate();//세션 만료 즉 로그아웃 처리
				
				out.println("<script>");
				out.println("alert('회원 탈퇴 했습니다!');");
				out.println("location='login';");
				out.println("</script>");
			}
		}		
		return null;
	}//member_del_ok()
	
}
