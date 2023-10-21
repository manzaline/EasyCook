package net.easycook.service;

import java.util.List;

import net.easycook.vo.AdminFaqVO;

public interface AdminFaqService {

	int getListCount(AdminFaqVO af);

	List<AdminFaqVO> getFaqList(AdminFaqVO af);

	void insertFaq(AdminFaqVO af);

	AdminFaqVO getfaqCont(int adminfaq_no);

	void updateFaq(AdminFaqVO af);

	void deleteBoard(int no);

}
