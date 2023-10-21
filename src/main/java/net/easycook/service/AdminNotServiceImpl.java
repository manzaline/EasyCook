package net.easycook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.AdminNotDAO;
import net.easycook.vo.AdminNoticeVO;

@Service
public class AdminNotServiceImpl implements AdminNotService {

	@Autowired
	private AdminNotDAO adminnotDAO;
	@Override
	public int getListCount(AdminNoticeVO an) {
		return this.adminnotDAO.getListCount(an);
	}
	@Override
	public List<AdminNoticeVO> getNotList(AdminNoticeVO an) {
		return this.adminnotDAO.getNotList(an);
	}
	@Override
	public void insertNot(AdminNoticeVO an) {
		this.adminnotDAO.insertNot(an);
		
	}
	@Override
	public void updateNot(AdminNoticeVO an) {
		this.adminnotDAO.updateNot(an);
	}
	@Override
	public void deleteBoard(int no) {
		this.adminnotDAO.deleteBoard(no);
		
	}
	@Override
	public AdminNoticeVO getNoticeCont(int adminnotice_no) {
		return this.adminnotDAO.getNoticeCont(adminnotice_no);
	}


}
