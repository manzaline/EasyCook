package net.easycook.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import net.easycook.service.HotNewsService;
import net.easycook.vo.HotNewsBoardVO;

@Controller
public class HotNewsBoardController {

	@Autowired
	private HotNewsService hotNewsService;
	
	@RequestMapping("/hotNewsBoard_view")
	public ModelAndView hotNewsBoard_view(ModelAndView mav, HttpServletRequest req, @ModelAttribute HotNewsBoardVO hvo) throws Exception{
		int page=1;
		int limit=9;
		if(req.getParameter("page") != null) {
			page=Integer.parseInt(req.getParameter("page"));
		}
		
		//검색필드와 검색어
		String find_field=req.getParameter("find_field");
		String find_name=req.getParameter("find_name");
		hvo.setFind_field(find_field);
		hvo.setFind_name("%"+find_name+"%"); //%는 검색에서 하나이상의 임의의 모르는 문자와 매핑 대응한다.
		
		int totalCount=this.hotNewsService.getTotalCount(hvo); //검색전은 총레코드 개수, 검색이후에는 검색된 레코드 개수

		hvo.setStartrow((page-1)*9+1); //시작 행번호
		hvo.setEndrow(hvo.getStartrow()+limit-1); //끝행번호
		
		List<HotNewsBoardVO> hlistv=this.hotNewsService.getBoardListView();
		List<HotNewsBoardVO> hlist=this.hotNewsService.getBoardList(hvo);		

		int maxpage=(int)((double)totalCount/limit+0.95); //총페이지수
		int startpage=(((int)((double)page/10+0.9))-1)*9+1; //현재 페이지에 보여질 시작 페이지
		int endpage=maxpage; //현재 페이지에 보여질 마지막 페이지
		
		if(endpage>startpage+10-1) endpage=startpage+10-1;
		
		mav.addObject("totalCount",totalCount);
		mav.addObject("hlistv", hlistv);
		mav.addObject("hlist", hlist);
		mav.addObject("page", page);
		mav.addObject("startpage", startpage);
		mav.addObject("endpage",endpage);
		mav.addObject("maxpage", maxpage);
		mav.addObject("totalCount", totalCount);
		mav.addObject("find_field", find_field);
		mav.addObject("find_name", find_name);
		mav.setViewName("hotNewsBoard/hotNewsBoard_view");
		
		return mav;
	}//hotNewsBoard_view()
	
	
	//핫뉴스페이지에서 게시물클릭 (조회수 증가O)
		@RequestMapping("/hotNewsBoard_cont")
		public String hotNewsBoard_cont(Model m, HttpServletRequest req, @RequestParam("hno") int hno, int page) {
			
			this.hotNewsService.getBoardCont(hno);

			//검색필드와 검색어
			String find_field=req.getParameter("find_field");
			String find_name=req.getParameter("find_name");
			
			m.addAttribute("page", page);
			m.addAttribute("find_field", find_field);
			m.addAttribute("find_name", find_name);	
			return "redirect:hotNewsBoard_view";
		}//hotNewsBoard_cont()
}

















