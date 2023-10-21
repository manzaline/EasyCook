package net.easycook.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.AdminService;
import net.easycook.service.RecipeBoardService;
import net.easycook.vo.RecipeBoardVO;

@Controller
public class admin_postController {
	
	@Autowired
	private RecipeBoardService recipeBoardService;
	
	@RequestMapping("/admin_post_list")
	public ModelAndView admin_post_list(HttpServletRequest request) {
		ModelAndView m = new ModelAndView();
		RecipeBoardVO rb = new RecipeBoardVO();
		
		int page=1;
		if(request.getParameter("page") != null) {
			page=Integer.parseInt(request.getParameter("page"));
		}

		//검색 타입 지정 : t(제목), w(글쓴이)
		String searchType = "";
		if(request.getParameter("searchType") != null) {
			searchType = request.getParameter("searchType");
		}
		rb.setSearchType(searchType);
		
		//검색어 지정
		String searchText = "";
		if(request.getParameter("searchText") != null) {
			searchText = request.getParameter("searchText");
		}
		searchText = "%"+searchText+"%";
		rb.setSearchText(searchText);

		int totalPostings = recipeBoardService.getTotalPostings(rb);
		m.addObject("totalPostings", totalPostings);
		
		rb.setStartNum(page*10-9);
		rb.setEndNum(page*10);
		List<RecipeBoardVO> rbList = recipeBoardService.getPostingList(rb);
		
		m.addObject("page",page);
		m.addObject("rbList", rbList);
		m.addObject("searchType", searchType);
		searchText = searchText.replace("%", "");
		m.addObject("searchText", searchText);
		m.setViewName("admin_post/admin_post_list");
		return m;
	}
	
	@RequestMapping("/admin_post_management")
	public ModelAndView admin_post_management() {
		ModelAndView ap=new ModelAndView();
		ap.setViewName("admin_post/admin_post_management");
		return ap;
	}
}
