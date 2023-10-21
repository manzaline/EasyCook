package net.easycook.service;

import java.util.List;

import net.easycook.vo.FaqBoardVO;
import net.easycook.vo.AdminFaqVO;

public interface FaqService {

	int getListCount(AdminFaqVO af);

	List<AdminFaqVO> getFaqList(AdminFaqVO af);


}
