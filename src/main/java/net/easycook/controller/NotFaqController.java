package net.easycook.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.AdminNotService;
import net.easycook.vo.AdminNoticeVO;

@Controller
public class NotFaqController {
	
	@Autowired
	private AdminNotService adminnotService;
	//공지사항 목록
	@RequestMapping("/Notice")
	public ModelAndView Notice(HttpServletRequest request, @ModelAttribute AdminNoticeVO an) {
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
		
		ModelAndView wm=new ModelAndView();
		wm.addObject("anlist",anlist);//blist키이름에 목록저장
		wm.addObject("page",page);//page키이름에 쪽번호 저장
		wm.addObject("startpage",startpage);
		wm.addObject("endpage",endpage);
		wm.addObject("maxpage",maxpage);
		wm.addObject("totalCount",listcount);//totalCount키이름에 총 레코드 개수 저장
		wm.addObject("find_field",find_field);//find_field 속성 키이름에 검색필드를 저장
		wm.addObject("find_name", find_name);
		//검색필드
		wm.setViewName("NoticeFaq/Notice");
		//wm.addAttribute("page",page);		
		return wm;
	
	}
}
