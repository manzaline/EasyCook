package net.easycook.service;

import java.util.List;

import net.easycook.vo.AdminNoticeVO;

public interface AdminNotService {

	int getListCount(AdminNoticeVO an);

	List<AdminNoticeVO> getNotList(AdminNoticeVO an);

	void insertNot(AdminNoticeVO an);

	void updateNot(AdminNoticeVO an);

	void deleteBoard(int no);

	AdminNoticeVO getNoticeCont(int adminnotice_no);
}
