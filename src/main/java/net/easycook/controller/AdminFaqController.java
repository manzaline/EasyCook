package net.easycook.controller;

import java.io.PrintWriter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.AdminFaqService;
import net.easycook.vo.AdminFaqVO;



@Controller
public class AdminFaqController {

	@Autowired
	private AdminFaqService adminfaqService;

	@RequestMapping("/adminfaq")
	public ModelAndView adminfaq(HttpServletRequest request,HttpServletResponse response,@ModelAttribute AdminFaqVO af)throws Exception {
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String id =(String)session.getAttribute("id");
		Integer state=(Integer)session.getAttribute("state");
		if(id ==null && state == 1 && state == 2) {
			out.println("<script>");
			out.println("alert('다시 로그인하세요');");
			out.println("location='login'");
			out.println("</script>");
		}else {
			int page=1;
			int limit=7;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));
			}

			String find_field=request.getParameter("find_field");
			String find_name=request.getParameter("find_name");

			af.setFind_field(find_field);
			af.setFind_name("%"+find_name+"%");

			int listcount=this.adminfaqService.getListCount(af);

			af.setStartrow((page-1)*7+1);
			af.setEndrow(af.getStartrow()+limit-1);

			List<AdminFaqVO> aflist = this.adminfaqService.getFaqList(af);

			//총페이지
			int maxpage=(int)((double)listcount/limit+0.95);

			int startpage=(((int)((double)page/10+0.9))-1)*7+1;

			int endpage=maxpage;
			if(endpage > startpage+7-1) endpage=startpage+7-1;

			ModelAndView amw=new ModelAndView();
			amw.addObject("aflist",aflist);//blist키이름에 목록저장
			amw.addObject("page",page);//page키이름에 쪽번호 저장
			amw.addObject("startpage",startpage);
			amw.addObject("endpage",endpage);
			amw.addObject("maxpage",maxpage);
			amw.addObject("totalCount",listcount);//totalCount키이름에 총 레코드 개수 저장
			amw.addObject("find_field",find_field);//find_field 속성 키이름에 검색필드를 저장
			amw.addObject("find_name", find_name);
			//검색필드
			amw.setViewName("NoticeFaq/adminfaq");
			//wm.addAttribute("page",page);		
			return amw;
			}
		return null;
	}
	
		//글작성
		@RequestMapping(value="/faqwrite",method=RequestMethod.GET)
		public ModelAndView faqwrite(HttpServletResponse response, HttpServletRequest request) 
				throws Exception{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();
			String id =(String)session.getAttribute("id");
			Integer state=(Integer)session.getAttribute("state");
			if(id ==null && state == 1 && state == 2) {
				out.println("<script>");
				out.println("alert('다시 로그인하세요');");
				out.println("location='login'");
				out.println("</script>");
			}else {
				int page=1;
				if(request.getParameter("page") != null) {
					page=Integer.parseInt(request.getParameter("page"));
				}
				ModelAndView mvf = new ModelAndView("NoticeFaq/faqwrite");
				mvf.addObject("page", page);
				return mvf;
			}
			return null;
		}
		
		//글작성완료
		@RequestMapping(value="/faqwrite_ok", method=RequestMethod.POST)
		public ModelAndView faqwrite_ok(@ModelAttribute AdminFaqVO af ,HttpServletRequest request,HttpServletResponse response)throws Exception{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();
			String id =(String)session.getAttribute("id");
			Integer state=(Integer)session.getAttribute("state");
			if(id ==null && state == 1 && state == 2) {
				out.println("<script>");
				out.println("alert('다시 로그인하세요');");
				out.println("location='login'");
				out.println("</script>");
			}else {
				this.adminfaqService.insertFaq(af);

				return new ModelAndView("redirect:/adminfaq");
			}
			return null;
		}

		//글수정
		@RequestMapping(value="/faqEdit",method=RequestMethod.GET)
		public ModelAndView faqEdit(HttpServletResponse response, HttpServletRequest request, int adminfaq_no) 
				throws Exception{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();
			String id =(String)session.getAttribute("id");
			Integer state=(Integer)session.getAttribute("state");
			if(id ==null && state == 1 && state == 2) {
				out.println("<script>");
				out.println("alert('다시 로그인하세요');");
				out.println("location='login'");
				out.println("</script>");
			}else {
				int page=1;
				if(request.getParameter("page") != null) {
					page=Integer.parseInt(request.getParameter("page"));
				}
				
				AdminFaqVO afaq = adminfaqService.getfaqCont(adminfaq_no);
				ModelAndView mv = new ModelAndView("NoticeFaq/faqEdit");
				mv.addObject("afaq", afaq);
				mv.addObject("page", page);
				
				return mv;
			}
			return null;
		}

		//수정완료
		@RequestMapping(value="/faqEdit_ok", method=RequestMethod.POST)
		public ModelAndView faqEdit_ok(@ModelAttribute AdminFaqVO af ,HttpServletRequest request,HttpServletResponse response,int page)throws Exception{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();
			String id =(String)session.getAttribute("id");
			Integer state=(Integer)session.getAttribute("state");
			if(id ==null && state == 1 && state == 2) {
				out.println("<script>");
				out.println("alert('다시 로그인하세요');");
				out.println("location='login'");
				out.println("</script>");
			}else {
				this.adminfaqService.updateFaq(af);
				return new ModelAndView("redirect:/adminfaq?page="+page);
			}
			return null;
		}
		

		@RequestMapping("/faqDelete")
		public String faqDelete(
				@RequestParam("adminfaq_no") int no,
				@RequestParam("page") int page,
				HttpServletResponse response,
				HttpServletRequest request)
						throws Exception{
			response.setContentType("text/html;charset=UTF-8");
			PrintWriter out=response.getWriter();
			HttpSession session=request.getSession();

			String id =(String)session.getAttribute("id");
			Integer state=(Integer)session.getAttribute("state");
			if(id ==null && state == 1 && state == 2) {
				out.println("<script>");
				out.println("alert('다시 관리자로 로그인 하세요!');");
				out.println("location='login';");
				out.println("</script>");
			}else {
				this.adminfaqService.deleteBoard(no);
				return "redirect:/adminfaq?page="+page;
			}		  
			return null;
		}
	}
