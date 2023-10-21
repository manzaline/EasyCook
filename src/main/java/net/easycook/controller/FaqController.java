package net.easycook.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.AdminFaqService;
import net.easycook.vo.AdminFaqVO;

@Controller
public class FaqController {
	
	@Autowired
	private AdminFaqService adminfaqService;
	@RequestMapping("/FAQ")
	public ModelAndView FAQ(HttpServletRequest request,@ModelAttribute AdminFaqVO af) {
		int page=1;
		int limit=7;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}
		String find_field=request.getParameter("find_field");
		String find_name=request.getParameter("find_name");
		
		af.setFind_field(find_field);
		af.setFind_name("%"+find_name+"%");
		
		int listcount2=this.adminfaqService.getListCount(af);
		
		af.setStartrow((page-1)*7+1);
		af.setEndrow(af.getStartrow()+limit-1);
		
		List<AdminFaqVO> aflist = this.adminfaqService.getFaqList(af);
		
		//총페이지
		int maxpage=(int)((double)listcount2/limit+0.95);
		
		int startpage=(((int)((double)page/7+0.9))-1)*7+1;
		
		int endpage=maxpage;
		if(endpage > startpage+7-1) endpage=startpage+7-1;
		
		ModelAndView ma=new ModelAndView();
		ma.addObject("aflist",aflist);//blist키이름에 목록저장
		ma.addObject("page",page);//page키이름에 쪽번호 저장
		ma.addObject("startpage",startpage);
		ma.addObject("endpage",endpage);
		ma.addObject("maxpage",maxpage);
		ma.addObject("totalCount",listcount2);//totalCount키이름에 총 레코드 개수 저장
		ma.addObject("find_field",find_field);//find_field 속성 키이름에 검색필드를 저장
		ma.addObject("find_name", find_name);
		//검색필드
		ma.setViewName("NoticeFaq/FAQ");
		//wm.addAttribute("page",page);		
		return ma;
		
	}
}
