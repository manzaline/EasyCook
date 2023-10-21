package net.easycook.service;

import java.util.List;

import net.easycook.vo.AdminNoticeVO;

public interface NotService {

	List<AdminNoticeVO> getNotList(AdminNoticeVO an);

	int getListCount(AdminNoticeVO an);

}
