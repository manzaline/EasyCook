package net.easycook.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.easycook.vo.MemberVO;

@Repository
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void insertMember(MemberVO m) {
		this.sqlSession.insert("m_in", m);
	} //회원저장

	@Override
	public MemberVO loginCheck(String login_id_box) {
		return this.sqlSession.selectOne("login_ck", login_id_box);
	} //로그인 인증

	@Override
	public MemberVO idcheck(String id) {
		return this.sqlSession.selectOne("m_check", id);
	} //아이디 중복검색
	
	@Override
	public void editMember(MemberVO m) {
		this.sqlSession.update("edit_ok",m);		
	}//회원 정보 수정
	
	@Override
	public MemberVO getMember(String id) {
		return this.sqlSession.selectOne("m_edit",id);
	}//회원정보 가져오기
	
	@Override
	public void delMem(MemberVO dm) {
		this.sqlSession.update("m_del",dm);		
	}//회원탈퇴

	@Override
	public String id_find(MemberVO m) {
		return this.sqlSession.selectOne("id_find", m);
	}

	@Override
	public String getPwdId(MemberVO mv) {
		return sqlSession.selectOne("get_Pwd_id", mv);
	}

	@Override
	public void updatePwd(MemberVO mv) {
		sqlSession.update("change_pwd", mv);	
	}







	
}
