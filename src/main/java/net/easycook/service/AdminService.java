package net.easycook.service;

import java.util.List;

import net.easycook.vo.MemberVO;

public interface AdminService {

	int getListCount(MemberVO m);

	List<MemberVO> getMemberList(MemberVO m);

	void editM(MemberVO m);

	MemberVO getMem(String join_id_box);

	void delM(String join_id_box);

	void editM_pwd(MemberVO m);

}
