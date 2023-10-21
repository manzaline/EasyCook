package net.easycook.service;


import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.AdminDAO;
import net.easycook.vo.MemberVO;

@Service
public class AdminServiceImpl implements AdminService {

	@Autowired
	private AdminDAO adminDAO;

	@Override
	public int getListCount(MemberVO m) {
		return this.adminDAO.getListCount(m);
	}

	@Override
	public List<MemberVO> getMemberList(MemberVO m) {
		return this.adminDAO.getMemberList(m);
	}

	@Override
	public void editM(MemberVO m) {
		this.adminDAO.editM(m);
	}

	@Override
	public MemberVO getMem(String join_id_box) {
		return this.adminDAO.getMem(join_id_box);
	}

	@Override
	public void delM(String join_id_box) {
		this.adminDAO.delM(join_id_box);
	}

	@Override
	public void editM_pwd(MemberVO m) {
		this.adminDAO.editM_pwd(m);
	}


}
