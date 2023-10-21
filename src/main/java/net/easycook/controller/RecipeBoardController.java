package net.easycook.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Calendar;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.oreilly.servlet.MultipartRequest;

import net.easycook.service.RecipeBoardService;
import net.easycook.vo.RecipeBoardCommentVO;
import net.easycook.vo.RecipeBoardVO;

@Controller
public class RecipeBoardController {
	
	@Autowired
	private RecipeBoardService recipeBoardService;

	@RequestMapping("/recipeBoard_view")
	public ModelAndView recipeBoard_view(HttpServletRequest req) {
		ModelAndView m = new ModelAndView();
		RecipeBoardVO rb = new RecipeBoardVO();
		
		//검색 타입 지정 : t(제목), w(글쓴이)
		String searchType = "";
		if(req.getParameter("searchType") != null) {
			searchType = req.getParameter("searchType");
		}
		rb.setSearchType(searchType);
		
		//검색어 지정
		String searchText = "";
		if(req.getParameter("searchText") != null) {
			searchText = req.getParameter("searchText");
		}
		searchText = "%"+searchText+"%";
		rb.setSearchText(searchText);
		
		//전체 게시글 수 검색
		int totalPostings = recipeBoardService.getTotalPostings(rb);
		m.addObject("totalPostingsObj", totalPostings);
		
		int page = 1;
		if(req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
			m.addObject("page", page);
		}
		int post = 0;
		if(req.getParameter("post") != null) {
			post = Integer.parseInt(req.getParameter("post"));
			m.addObject("post", post);
		}
		int cpage = 1;
		if(req.getParameter("cpage") != null) {
			cpage = Integer.parseInt(req.getParameter("cpage"));
			m.addObject("cpage", cpage);
		}
		
		//현재 페이지를 기준으로 8개의 게시글 조회
		rb.setStartNum(page*8-7);
		rb.setEndNum(page*8);
		List<RecipeBoardVO> rbList = recipeBoardService.getPostingList(rb, post);
		
		//선택된 게시글이 있을 경우 해당 게시글의 댓글 조회
		if(post != 0) {
			//전체 댓글 수 조회
			int totalComments = recipeBoardService.getTotalComments(post);
			m.addObject("totalComments", totalComments);
			//현재 댓글 페이지를 기준으로 10개의 댓글 조회
			RecipeBoardCommentVO rbc = new RecipeBoardCommentVO();
			rbc.setRno(post);
			rbc.setStartNum(cpage*10-9);
			rbc.setEndNum(cpage*10);
			List<RecipeBoardCommentVO> rbcList = recipeBoardService.getCommentList(rbc);
			m.addObject("rbcList", rbcList);
		}
		
		m.addObject("rbList", rbList);
		m.addObject("searchType", searchType);
		searchText = searchText.replace("%", "");
		m.addObject("searchText", searchText);
		
		m.setViewName("recipeBoard/recipeBoard_view");
		
		return m;
	}//recipeBoard_view()
	
	@RequestMapping("/recipeBoard_write")
	public ModelAndView recipeBoard_write(HttpServletRequest req) {
		ModelAndView m = new ModelAndView();
		m.setViewName("recipeBoard/recipeBoard_write");
		return m;
	}//recipeBoard_write()
	
	@ResponseBody
	@RequestMapping(value = "/recipe_write_ok", method = RequestMethod.POST)
	public String recipe_write_ok(
			@RequestParam("imgFiles") List<MultipartFile> list, @RequestParam("imgIndex") String imgIndex, 
			HttpServletRequest req, HttpSession session) throws Exception{
		
		if(list.isEmpty()) {
			System.out.println("[성공:/recipe_write_ok] 전송된 이미지 파일 없음");
		}else {
			System.out.println("[성공:/recipe_write_ok] 전송된 이미지 INDEX : ["+imgIndex+"]");
		}
		RecipeBoardVO rb = new RecipeBoardVO();
		rb.setWriterid((String)session.getAttribute("id"));
		rb.setTitle(req.getParameter("title"));
		rb.setVideoLink(req.getParameter("link"));
		rb.setTextPack(req.getParameter("textPack"));
		rb.setImgIndex(imgIndex);

		//for(int i=0; i<=90; i++) { //테스트 데이터 입력을 위한 반복문 *꼭 주석처리 할 것
		//이미지 저장 폴더 지정
		Calendar c = Calendar.getInstance();
		int year = c.get(Calendar.YEAR);
		int month = c.get(Calendar.MONTH)+1; if(month < 10) year *= 10; // 자릿수를 맞춰주기 위해 0추가
		int date = c.get(Calendar.DATE); if(date < 10) month *= 10;
		int hour = c.get(Calendar.HOUR_OF_DAY); if(hour < 10) date *= 10;
		int minute = c.get(Calendar.MINUTE); if(minute < 10) hour *= 10;
		int second = c.get(Calendar.SECOND); if(second < 10) minute *= 10;
		
		String folderName = ""+year+month+date+hour+minute+second;
		rb.setImgFolder(folderName);
		
		//이미지 폴더명을 지정하기 위해 insert후 no값을 return
		recipeBoardService.writeRec(rb);
		System.out.println("[성공:/recipe_write_ok] 저장된 레코드 NO : "+ rb.getNo());
		folderName = folderName+rb.getNo();
		
		//이미지 폴더 경로 지정
		String saveFolder=req.getRealPath("upload");
		String homeDir = saveFolder + "\\" + folderName;
		File path = new File(homeDir);
		if(!path.exists()) {
			path.mkdirs();
		}
		//파일 이름을 1.jpg, 2.jpg...등으로 저장
		int fileNameIndex = 1;
		for(MultipartFile f:list) {
			int exIndex = f.getOriginalFilename().lastIndexOf(".");
			//String fileEx = f.getOriginalFilename().substring(exIndex+1); //일단 jpg로만 저장함
			File target = new File(path, fileNameIndex + ".jpg");
			FileCopyUtils.copy(f.getBytes(), target);
			System.out.println("[성공:/recipe_write_ok] 저장된 파일명 : "+ path + "\\" + f.getOriginalFilename());
			fileNameIndex++;
		}
		//} //테스트 데이터 입력용 반복문 종료
		
		return "OK";

	}//recipe_write_ok()
	
	@RequestMapping("recipeBoard_delete")
	public String recipeBoard_remove(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		int post = Integer.parseInt(req.getParameter("post"));
		RecipeBoardVO rb = recipeBoardService.getPost(post);

		recipeBoardService.deleteCommentByRno(post);
		recipeBoardService.deletePost(post);
		System.out.println("[성공:/recipeBoard_delete] 삭제된 레코드 NO : "+ rb.getNo());
		String folderPath = req.getRealPath("upload")+"\\"+rb.getImgFolder();
		File targetFolder = new File(folderPath);
		if(targetFolder.exists()) {
			File[] targetFileArr = new File(folderPath).listFiles();
			for(File f:targetFileArr) {
				System.out.println("[성공:/recipeBoard_delete] 삭제된 파일명 : "+ folderPath + "\\" + f.getName());
				f.delete();
			}
			targetFolder.delete();
		}
		
		if(req.getParameter("type") != null) {
			System.out.println("삭제완료");
			return "redirect:admin_post_list";
		}
		
		return "redirect:recipeBoard_view?page=1";
	}
	
	@RequestMapping("recipeBoard_edit")
	public ModelAndView recipeBoard_edit(HttpServletRequest req, HttpServletResponse res, HttpSession session) throws IOException {
		res.setContentType("text/html;charset=UTF-8");
		PrintWriter out = res.getWriter();
		
		int post = Integer.parseInt(req.getParameter("post"));
		RecipeBoardVO rb = recipeBoardService.getPost(post);
			
		ModelAndView m = new ModelAndView();
		m.addObject("title", rb.getTitle());
		m.addObject("videoLink", rb.getVideoLink());
		m.addObject("imgIndex", rb.getImgIndex());
		m.addObject("imgFolder", rb.getImgFolder());
		m.addObject("textPack", rb.getTextPack());
		m.addObject("no", rb.getNo());
		
		m.setViewName("recipeBoard/recipeBoard_edit");
		return m;
	}
	
	@ResponseBody
	@RequestMapping("recipeBoard_edit_ok")
	public String recipeBoard_edit_ok(
			@RequestParam("imgFiles") List<MultipartFile> list, @RequestParam("imgIndex") String imgIndex, 
			@RequestParam("imgConvIndex") String imgConvIndex, HttpServletRequest req, HttpSession session) 
					throws Exception{

		/*
			상태 코드 : imgConvIndex
			0 사진이 없고 변경되지 않은 상태
			1 사진이 있고 변경되지 않은 상태
			2 사진이 없고 변경된 상태
			3 사진이 있고 변경된 상태
			4 사진이 없고 삭제된 상태
			5 사진이 있고 삭제된 상태
			예시)
			기존 코드 : 100110
			이미지 저장 : 1, 2, 3
			이미지 이름 임시 변경 : a1, a2, a3
			상태 코드 : 520134
			5: a1삭제
			2: 첫번째 파일을 1.jpg로 저장, index 1
			0: index 10
			1: a2를 2.jpg로 저장, index 101
			3: 두번째 파일을 3.jpg로 저장하고 a3 삭제, index 1011
			4: 무시
		*/
		
		int post = Integer.parseInt(req.getParameter("editNo"));
		RecipeBoardVO rb = recipeBoardService.getPost(post);
			
		//이미지 업로드 코드////
		String folderPath = req.getRealPath("upload")+"\\"+rb.getImgFolder();
		File targetFolder = new File(folderPath);
		if(targetFolder.exists()) {
			//파일 이름을 a1.jpg, a2.jpg...로 임시 변경
			File[] targetFileArr = new File(folderPath).listFiles();
			for(File f:targetFileArr) {
				File tempFile = new File(folderPath + "/a" + f.getName());
				f.renameTo(tempFile);
			}
			//MultipartFile f = list.get(0);
			//System.out.println(f.getOriginalFilename());
			//list.remove(0);
			//System.out.println(list.size());
			//System.out.println(list.isEmpty());
			
			//상태코드에 따른 이미지 저장 및 수정, index변경
			String tempIndex = ""; // 변경될 index
			int tempImgIndex = 1; // 임시 파일을 지정하는 변수
			int saveImgIndex = 1; // 저장할 파일명을 지정하는 변수
			MultipartFile f = null; // 전달받은 이미지를 저장할 변수
			File tempFile = null; // 임시파일
			File saveFile = null; // 저장될 파일
			for(int i=0; i<=imgConvIndex.length()-1; i++) {
				switch (imgConvIndex.charAt(i)) {
				case '0': //사진이 없고 변경되지 않은 상태
					tempIndex += '0';
					break;
				case '1': //사진이 있고 변경되지 않은 상태
					tempFile = new File(folderPath + "/a" + tempImgIndex + ".jpg");
					saveFile = new File(folderPath + "/" + saveImgIndex + ".jpg");
					tempFile.renameTo(saveFile);
					tempIndex += '1';
					tempImgIndex++;
					saveImgIndex++;
					break;
				case '2': //사진이 없고 변경된 상태
					f = list.get(0);
					saveFile = new File(folderPath + "/" + saveImgIndex + ".jpg");
					FileCopyUtils.copy(f.getBytes(), saveFile);
					list.remove(0);
					tempIndex += '1';
					saveImgIndex++;
					break;
				case '3': //사진이 있고 변경된 상태
					f = list.get(0);
					tempFile = new File(folderPath + "/a" + tempImgIndex + ".jpg");
					saveFile = new File(folderPath + "/" + saveImgIndex + ".jpg");
					FileCopyUtils.copy(f.getBytes(), saveFile);
					tempFile.delete();
					list.remove(0);
					tempIndex += '1';
					tempImgIndex++;
					saveImgIndex++;
					break;
				case '4': //사진이 없고 삭제된 상태
					System.out.println("아무 행동도 하지 않음");
					break;
				case '5': //사진이 있고 삭제된 상태
					tempFile = new File(folderPath + "/a" + tempImgIndex + ".jpg");
					tempFile.delete();
					tempImgIndex++;
					break;
				default:
					break;
				}
			}
			if(!list.isEmpty()) {
				for(MultipartFile fl:list) {
					saveFile = new File(folderPath + "/" + saveImgIndex + ".jpg");
					FileCopyUtils.copy(fl.getBytes(), saveFile);
					saveImgIndex++;
				}
			}
			//임시 index로 전달받은 index의 앞부분을 치환
			imgIndex = imgIndex.substring(tempIndex.length(), imgIndex.length());
			imgIndex = tempIndex + imgIndex;
		}
		//이미지 업로드 코드 END////
		
		RecipeBoardVO rbv = new RecipeBoardVO();
		rbv.setNo(rb.getNo());
		rbv.setTitle(req.getParameter("title"));
		rbv.setVideoLink(req.getParameter("link"));
		rbv.setTextPack(req.getParameter("textPack"));
		rbv.setImgIndex(imgIndex);
		
		recipeBoardService.editPost(rbv);
		System.out.println("[성공:/recipe_edit_ok] 이미지 INDEX : ["+imgIndex+"]");
		System.out.println("[성공:/recipe_edit_ok] 수정된 레코드 NO : "+rb.getNo());
		
		return "OK";
	}
	
	@RequestMapping("commentWrite")
	public ModelAndView commentWrite(RecipeBoardCommentVO rbc, HttpServletRequest req) {
		ModelAndView m = new ModelAndView();
		
		recipeBoardService.writeComment(rbc);
		
		int page = 1;
		if(req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		String searchType = "";
		if(req.getParameter("searchType") != null) {
			searchType = req.getParameter("searchType");
		}
		String searchText = "";
		if(req.getParameter("searchText") != null) {
			searchText = req.getParameter("searchText");
		}
		m.addObject("page", page);
		m.addObject("post", rbc.getRno());
		m.addObject("cpage", 1);
		m.addObject("searchType", searchType);
		m.addObject("searchText", searchText);
		m.setViewName("redirect:/recipeBoard_view");
		return m;
	}
	
	@RequestMapping("commentDelete")
	public ModelAndView commentDelete(HttpServletRequest req) {
		ModelAndView m = new ModelAndView();

		int cno = Integer.parseInt(req.getParameter("cno"));
		recipeBoardService.deleteComment(cno);

		int page = 1;
		if(req.getParameter("page") != null) {
			page = Integer.parseInt(req.getParameter("page"));
		}
		int post = Integer.parseInt(req.getParameter("post"));
		
		String searchType = "";
		if(req.getParameter("searchType") != null) {
			searchType = req.getParameter("searchType");
		}
		String searchText = "";
		if(req.getParameter("searchText") != null) {
			searchText = req.getParameter("searchText");
		}
		m.addObject("page", page);
		m.addObject("post", post);
		m.addObject("cpage", 1);
		m.addObject("searchType", searchType);
		m.addObject("searchText", searchText);
		m.setViewName("redirect:/recipeBoard_view");
		return m;
	}
	
}
