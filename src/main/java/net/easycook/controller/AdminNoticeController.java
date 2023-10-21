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
import net.easycook.service.AdminNotService;
import net.easycook.vo.AdminNoticeVO;

@Controller
public class AdminNoticeController {

	@Autowired
	private AdminNotService adminnotService;

	@RequestMapping("/adminnotice")
	public ModelAndView adminnotice(HttpServletRequest request,HttpServletResponse response, @ModelAttribute AdminNoticeVO an) throws Exception{
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

			an.setFind_field(find_field);
			an.setFind_name("%"+find_name+"%");

			int listcount=this.adminnotService.getListCount(an);

			an.setStartrow((page-1)*7+1);
			an.setEndrow(an.getStartrow()+limit-1);

			List<AdminNoticeVO> anlist = this.adminnotService.getNotList(an);

			//총페이지
			int maxpage=(int)((double)listcount/limit+0.95);

			int startpage=(((int)((double)page/7+0.9))-1)*7+1;

			int endpage=maxpage;
			if(endpage > startpage+7-1) endpage=startpage+7-1;

			ModelAndView awm=new ModelAndView();
			awm.addObject("anlist",anlist);
			awm.addObject("page",page);
			awm.addObject("startpage",startpage);
			awm.addObject("endpage",endpage);
			awm.addObject("maxpage",maxpage);
			awm.addObject("totalCount",listcount);
			awm.addObject("find_field",find_field);
			awm.addObject("find_name", find_name);
			awm.setViewName("NoticeFaq/adminnotice");		
			return awm;
		}
		return null;
	}


	//글작성
	@RequestMapping(value="/noticewrite",method=RequestMethod.GET)
	public ModelAndView noticewrite(HttpServletResponse response, HttpServletRequest request) 
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
			ModelAndView mv = new ModelAndView("NoticeFaq/noticewrite");
			mv.addObject("page", page);
			return mv;
		}
		return null;
	}


	//글작성완료
	@RequestMapping(value="/noticewrite_ok", method=RequestMethod.POST)
	public ModelAndView noticewrite_ok(@ModelAttribute AdminNoticeVO an ,HttpServletRequest request,HttpServletResponse response)throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String id =(String)session.getAttribute("id");
		Integer state=(Integer)session.getAttribute("state");
		if(id ==null && state == 1 && state == 2) {
			out.println("<script>");
			out.println("alert('다시 로그인하세요');");
			out.println("location='/'");
			out.println("</script>");
		}else {
			this.adminnotService.insertNot(an);

			return new ModelAndView("redirect:/adminnotice");
		}
		return null;
	}

	//글수정
	@RequestMapping(value="/noticeEdit",method=RequestMethod.GET)
	public ModelAndView noticeEdit(HttpServletResponse response, HttpServletRequest request, int adminnotice_no) 
			throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String id =(String)session.getAttribute("id");
		Integer state=(Integer)session.getAttribute("state");
		if(id ==null && state == 1 && state == 2) {
			out.println("<script>");
			out.println("alert('다시 로그인하세요');");
			out.println("location='/'");
			out.println("</script>");
		}else {
			int page=1;
			if(request.getParameter("page") != null) {
				page=Integer.parseInt(request.getParameter("page"));
			}
			
			AdminNoticeVO anotice = adminnotService.getNoticeCont(adminnotice_no);
			ModelAndView mv = new ModelAndView("NoticeFaq/noticeEdit");
			mv.addObject("anotice", anotice);
			mv.addObject("page", page);
			
			return mv;
		}
		return null;
	}

	//수정완료
	@RequestMapping(value="/noticeEdit_ok", method=RequestMethod.POST)
	public ModelAndView noticeEdit_ok(@ModelAttribute AdminNoticeVO an ,HttpServletRequest request,HttpServletResponse response,int page)throws Exception{
		response.setContentType("text/html;charset=UTF-8");
		PrintWriter out=response.getWriter();
		HttpSession session=request.getSession();
		String id =(String)session.getAttribute("id");
		Integer state=(Integer)session.getAttribute("state");
		if(id ==null && state == 1 && state == 2) {
			out.println("<script>");
			out.println("alert('다시 로그인하세요');");
			out.println("location='/'");
			out.println("</script>");
		}else {
			this.adminnotService.updateNot(an);
			return new ModelAndView("redirect:/adminnotice?page="+page);
		}
		return null;
	}
	

	@RequestMapping("/noticeDelete")
	public String noticeDelete(
			@RequestParam("adminnotice_no") int no,
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
			out.println("location='admin_index';");
			out.println("</script>");
		}else {
			this.adminnotService.deleteBoard(no);
			return "redirect:/adminnotice?page="+page;
		}		  
		return null;
	}

}





