package net.easycook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.AdminFaqDAO;
import net.easycook.vo.AdminFaqVO;

@Service
public class AdminFaqServiceImpl implements AdminFaqService {

	@Autowired 
	private AdminFaqDAO adminfaqDAO;
	@Override
	public int getListCount(AdminFaqVO af) {
		return this.adminfaqDAO.getListCount(af);
	}
	@Override
	public List<AdminFaqVO> getFaqList(AdminFaqVO af) {
		return this.adminfaqDAO.getFaqList(af);
	}
	@Override
	public void insertFaq(AdminFaqVO af) {
		this.adminfaqDAO.insertFaq(af);
		
	}
	@Override
	public AdminFaqVO getfaqCont(int adminfaq_no) {
		return this.adminfaqDAO.getfaqCont(adminfaq_no);
	}
	@Override
	public void updateFaq(AdminFaqVO af) {
		this.adminfaqDAO.updateFaq(af);
		
	}
	@Override
	public void deleteBoard(int no) {
		this.adminfaqDAO.deleteBoard(no);
		
	}

}
