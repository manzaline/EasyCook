package net.easycook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.AdminNotDAO;
import net.easycook.vo.AdminNoticeVO;

@Service
public class NotServiceImpl implements NotService {

	@Autowired
	private AdminNotDAO adminnotDAO;
	

	@Override
	public List<AdminNoticeVO> getNotList(AdminNoticeVO an) {
		return this.adminnotDAO.getNotList(an);
	}


	@Override
	public int getListCount(AdminNoticeVO an) {
		return this.adminnotDAO.getListCount(an);
	}




}
