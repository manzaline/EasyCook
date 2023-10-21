package net.easycook.controller;

import java.io.File;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.HotNewsService;
import net.easycook.vo.HotNewsBoardVO;
@Controller
public class AdminHotNewsController { //일반게시판 관리자게시판 합쳐있음

	@Autowired 
	private HotNewsService hotNewsService;	
	
	@RequestMapping("/admin_hotnews_write")
	public String admin_hotnews_write(HttpServletRequest req, HttpServletResponse resp, Model m) throws Exception{
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			int page=1;
			if(req.getParameter("page") != null) {
				page=Integer.parseInt(req.getParameter("page"));
			}
						
			m.addAttribute("page",page);
			
			return "hotNewsBoard/admin_hotnews_write";
		}
		
		return null;
	}//admin_hotNewsBoard_write()
	
	
	@RequestMapping("/admin_hotnews_write_ok")
	public String admin_hotnews_write_ok(@RequestParam MultipartFile hfile, @ModelAttribute HotNewsBoardVO hvo, 
			HttpServletRequest req, HttpServletResponse resp, Model m, int page) throws Exception {
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			
			//for(int i=1; i<15; i++) { //테스트데이터용 반복문 <<<꼭 주석처리 해야함>>>
			
			String saveFolder=req.getRealPath("upload"); //이진파일 업로드 서버 경로 => 톰캣 WAS 서버에 의해서 변경된 실제 톰캣 프로젝트 경로
//			int fileSize=5*1024*1024; //이진파일 업로드 최대크기(5MB)
			
			page=1;
			if(req.getParameter("page") != null) {
				page=Integer.parseInt(req.getParameter("page"));
			}
			
			if(hfile != null) { //첨부한 이진파일이 있는경우
				String fileName=hfile.getOriginalFilename(); //첨부한 이진파일명
				Calendar c=Calendar.getInstance(); //Calendar는 추상클래스여서 new로 객체생성 못함. 년월일 시분초 값을 구할 수 있다.
				int year=c.get(Calendar.YEAR); //년도값
				int month=c.get(Calendar.MONTH)+1; //월값. +1한이유 알지?
				int date=c.get(Calendar.DATE); //일값
				
				String homedir=saveFolder+"/"+year+"-"+month+"-"+date; //오늘날짜 폴더경로를 저장
				File path01=new File(homedir);
				if(!(path01.exists())) {//해당 경로가 없으면
					path01.mkdirs(); //폴더 경로를 생성
				}
				Random r=new Random();
				int random=r.nextInt(100000000); //0~1억 미만 사이의 정수형 숫자 난수를 발생
				
				/* 첨부한 파일 확장자를 구함 */
				int index=fileName.lastIndexOf("."); //첨부한 파일에서 .를 맨 오른쪽부터 찾아서 가장 먼저 나오는 .의 왼쪽부터의 인덱스번호를 반환 
				String fileExtendsion=fileName.substring(index+1); //.이후부터 마지막문자까지 반환. 즉 첨부한 파일의 확장자명.
				String refileName="bbs"+year+month+date+random+"."+fileExtendsion; //새로운 이진파일명 저장
				String fileDBName="/"+year+"-"+month+"-"+date+"/"+refileName; //데이터베이스에 저장될 레코드값
				
				FileCopyUtils.copy(hfile.getBytes(), new File(homedir+"/"+refileName)); //변경된 이진파일로 새롭게 생성된 폴더에 실제 업로드
				hvo.setHfile(fileDBName); //오라클에 저장될 레코드 값
			}else {//파일을 첨부하지 않았을때
				String fileDBName="";
				hvo.setHfile(fileDBName);
			}
			
			m.addAttribute("page",page);
			
			String htitle=req.getParameter("htitle");
			String hcont=req.getParameter("hcont");
			String hlink=req.getParameter("hlink");
			String hwriter=req.getParameter("hwriter");

			hvo.setHtitle(htitle); hvo.setHcont(hcont); hvo.setHlink(hlink);
			hvo.setHwriter(hwriter);
			
			this.hotNewsService.insertBoard(hvo);
			
			//}//테스트데이터용 반복문 <<<꼭 주석처리해야함>>>			
			
			return "redirect:/admin_hotnews_list?page="+page;
		}

		return null;
	}//admin_hotnews_write_ok()		
	
	
	@RequestMapping("/admin_hotnews_list")
	public String admin_hotnews_list(Model listM, HttpServletRequest req, HttpServletResponse resp, @ModelAttribute HotNewsBoardVO hvo) throws Exception{
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			int page=1;
			int limit=10;
			if(req.getParameter("page") != null) {
				page=Integer.parseInt(req.getParameter("page"));
			}
			
		//검색필드와 검색어
		String find_field=req.getParameter("find_field");
		String find_name=req.getParameter("find_name");
		hvo.setFind_field(find_field);
		hvo.setFind_name("%"+find_name+"%"); //%는 검색에서 하나이상의 임의의 모르는 문자와 매핑 대응한다.
		
		int totalCount=this.hotNewsService.getTotalCount(hvo); //총 게시물 수

		hvo.setStartrow((page-1)*10+1); //시작 행번호
		hvo.setEndrow(hvo.getStartrow()+limit-1); //끝행번호
		
		List<HotNewsBoardVO> hlist=this.hotNewsService.getBoardList(hvo);

		int maxpage=(int)((double)totalCount/limit+0.95); //총페이지수
		int startpage=(((int)((double)page/10+0.9))-1)*10+1; //현재 페이지에 보여질 시작 페이지
		int endpage=maxpage; //현재 페이지에 보여질 마지막 페이지
		
		if(endpage>startpage+10-1) endpage=startpage+10-1;
		
		listM.addAttribute("hvo",hvo);
		listM.addAttribute("hlist", hlist);
		listM.addAttribute("page", page);
		listM.addAttribute("startpage", startpage);
		listM.addAttribute("endpage", endpage);
		listM.addAttribute("maxpage", maxpage);
		listM.addAttribute("totalCount", totalCount);
		listM.addAttribute("find_field", find_field);
		listM.addAttribute("find_name", find_name);

		return "hotNewsBoard/admin_hotnews_list";
		}
		
		return null;
	}//admin_hotNewsBoard_list()	
	
	
	//관리자페이지에서 게시물클릭 (조회수 증가X)
	@RequestMapping("/admin_hotnews_cont")
	public String admin_hotnews_cont(Model m, HttpServletRequest req, HttpServletResponse resp, 
			@RequestParam("hno") int hno, int page, HotNewsBoardVO hvo, String state) throws Exception{
		
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			String ResultView=null;		
			
			//검색필드와 검색어
			String find_field=req.getParameter("find_field");
			String find_name=req.getParameter("find_name");
			
			m.addAttribute("page", page);
			m.addAttribute("find_field", find_field);
			m.addAttribute("find_name", find_name);	
			
			if(state.equals("cont")) {
				ResultView = "redirect:admin_hotnews_list";
			}else if(state.equals("edit")){
				ResultView = "redirect:admin_hotnews_edit";
			}else if(state.equals("del")){
				ResultView = "redirect:admin_hotnews_del";
			}
			
			return ResultView;
		}
		
		return null;
	}//admin_hotnews_cont()
	
	
	@RequestMapping("/admin_hotnews_edit")
	public ModelAndView admin_hotnews_edit(HttpServletRequest req, HttpServletResponse resp, int hno, int page, HotNewsBoardVO hvo) throws Exception {
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {

			String find_field=req.getParameter("find_field");
			String find_name=req.getParameter("find_name");
			
			hvo=this.hotNewsService.getBoardCont2(hno);
			
			ModelAndView mav = new ModelAndView();
			mav.addObject("hvo", hvo);
			mav.addObject("page", page);
			mav.addObject("find_field", find_field);
			mav.addObject("find_name", find_name);
			mav.setViewName("hotNewsBoard/admin_hotnews_edit");

			return mav;
		}
		
		return null;
	}//admin_hotNewsBoard_edit()
	
	
	@RequestMapping("admin_hotnews_edit_ok")
	public String admin_hotnews_edit_ok(@RequestParam MultipartFile hfile, @ModelAttribute HotNewsBoardVO hvo, 
			HttpServletRequest req, HttpServletResponse resp, int page, int hno) throws Exception{
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		HotNewsBoardVO delhvo=this.hotNewsService.getBoardCont2(hno);
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			String saveFolder=req.getRealPath("upload"); //이진파일 업로드 서버 경로 => 톰캣 WAS 서버에 의해서 변경된 실제 톰캣 프로젝트 경로
//			int fileSize=5*1024*1024; //이진파일 업로드 최대크기(5MB)
		
			if(!hfile.isEmpty()) { //첨부한 이진파일이 있는경우
				String fileName=hfile.getOriginalFilename(); //첨부한 이진파일명
				File delFile=new File(saveFolder+delhvo.getHfile()); //기존 첨부된 삭제할 파일 객체를 생성
				if(delFile.exists()) { //삭제할 파일이 있다면 삭제
					delFile.delete(); //기존 이진파일을 삭제
				}
				Calendar c=Calendar.getInstance(); //Calendar는 추상클래스여서 new로 객체생성 못함. 년월일 시분초 값을 구할 수 있다.
				int year=c.get(Calendar.YEAR); //년도값
				int month=c.get(Calendar.MONTH)+1; //월값. +1한이유 알지?
				int date=c.get(Calendar.DATE); //일값
				
				String homedir=saveFolder+"/"+year+"-"+month+"-"+date; //오늘날짜 폴더경로를 저장
				File path01=new File(homedir);
				if(!(path01.exists())) {//해당 경로가 없으면
					path01.mkdirs(); //폴더 경로를 생성
				}
				Random r=new Random();
				int random=r.nextInt(100000000); //0~1억 미만 사이의 정수형 숫자 난수를 발생
				
				/* 첨부한 파일 확장자를 구함 */
				int index=fileName.lastIndexOf("."); //첨부한 파일에서 .를 맨 오른쪽부터 찾아서 가장 먼저 나오는 .의 왼쪽부터의 인덱스번호를 반환 
				String fileExtendsion=fileName.substring(index+1); //.이후부터 마지막문자까지 반환. 즉 첨부한 파일의 확장자명.
				String refileName="bbs"+year+month+date+random+"."+fileExtendsion; //새로운 이진파일명 저장
				String fileDBName="/"+year+"-"+month+"-"+date+"/"+refileName; //데이터베이스에 저장될 레코드값
				
				FileCopyUtils.copy(hfile.getBytes(), new File(homedir+"/"+refileName)); //변경된 이진파일로 새롭게 생성된 폴더에 실제 업로드
				hvo.setHfile(fileDBName); //오라클에 저장될 레코드 값
			}else {//파일을 첨부하지 않았을때
				hvo = this.hotNewsService.getBoardCont2(hno);				
				hvo.setHfile(hvo.getHfile());
			}
			
			String hwriter=req.getParameter("hwriter");
			String htitle=req.getParameter("htitle");
			String hcont=req.getParameter("hcont");
			String hlink=req.getParameter("hlink");
			
			hvo.setHwriter(hwriter); hvo.setHtitle(htitle); hvo.setHcont(hcont); hvo.setHlink(hlink);
			
			this.hotNewsService.editBoard(hvo);
			
			return "redirect:/admin_hotnews_list?page="+page;	
		}
			
		return null;
	}//admin_hotnews_edit_ok()
	
	
	@RequestMapping("admin_hotnews_del")
	public String admin_hotnews_del(int hno, int page, HttpServletRequest req, HttpServletResponse resp) throws Exception{
		
		resp.setContentType("text/html;charset=UTF-8");
		PrintWriter out=resp.getWriter();
		HttpSession session=req.getSession();
		
		Integer auth_num=(Integer)session.getAttribute("state");
		
		if(auth_num == null || auth_num != 3) {
			session.invalidate();
			out.println("<script>");
			out.println("alert('잘못된 접근입니다.\\n\\n관리자계정으로 다시 로그인하세요 ^o^')");
			out.println("location='login';");
			out.println("</script>");
		}else {
			String db_filePath=req.getRealPath("upload");
			HotNewsBoardVO db_file=this.hotNewsService.getBoardCont2(hno);
			System.out.println(db_file.getHfile());
			this.hotNewsService.delBoard(hno); //게시물 삭제

			if(db_file.getHfile() != null) { //첨부파일이 있는경우
				File file=new File(db_filePath+db_file.getHfile());
				System.out.println(file);
				file.delete(); //upload폴더에서 첨부파일 삭제
			}
			return "redirect:/admin_hotnews_list?page="+page;
		}
		
		return null;
	}//admin_hotnews_del()

}




















