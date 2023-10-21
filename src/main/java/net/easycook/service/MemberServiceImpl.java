package net.easycook.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import net.easycook.dao.MemberDAO;
import net.easycook.vo.MemberVO;

@Service
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDAO memberDAO;
	
	@Override
	public void insertMember(MemberVO m) {
		this.memberDAO.insertMember(m);
	}

	@Override
	public MemberVO loginCheck(String login_id_box) {
		return this.memberDAO.loginCheck(login_id_box);
	}

	@Override
	public MemberVO idcheck(String id) {
		return this.memberDAO.idcheck(id);
	}
	
	@Override
	public void editMember(MemberVO m) {
		this.memberDAO.editMember(m);		
	}
	
	@Override
	public MemberVO getMember(String id) {
		return this.memberDAO.getMember(id);
	}
	
	@Override
	public void delMem(MemberVO dm) {
		memberDAO.delMem(dm);		
	}

	@Override
	public String id_find(MemberVO m) {
		return this.memberDAO.id_find(m);
	}

	@Override
	public String getPwdId(MemberVO mv) {
		return memberDAO.getPwdId(mv);
	}

	@Override
	public void updatePwd(MemberVO mv) {
		memberDAO.updatePwd(mv);
	}




}
