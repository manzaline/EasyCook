package net.easycook.dao;

import net.easycook.vo.MemberVO;

public interface MemberDAO {

	void insertMember(MemberVO m);

	MemberVO loginCheck(String login_id_box);

	MemberVO idcheck(String id);
	
	void editMember(MemberVO m);
	
	MemberVO getMember(String id);
	
	void delMem(MemberVO dm);

	String id_find(MemberVO m);

	String getPwdId(MemberVO mv);

	void updatePwd(MemberVO mv);






}
