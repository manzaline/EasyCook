package net.easycook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.FaqDAO;
import net.easycook.dao.AdminFaqDAO;
import net.easycook.vo.FaqBoardVO;
import net.easycook.vo.AdminFaqVO;

@Service
public class FaqServiceImpl implements FaqService {
	
	@Autowired
	private AdminFaqDAO adminfaqDAO;

	@Override
	public int getListCount(AdminFaqVO fb) {
		return this.adminfaqDAO.getListCount(fb);
	}

	@Override
	public List<AdminFaqVO> getFaqList(AdminFaqVO fb) {
		return this.adminfaqDAO.getFaqList(fb);
	}





}
