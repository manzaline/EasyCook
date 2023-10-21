package net.easycook.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.easycook.vo.MemberVO;

@Repository
public class AdminDAOImpl implements AdminDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public int getListCount(MemberVO m) {
		return this.sqlSession.selectOne("admin_count", m);
	} //검색전후 회원수

	@Override
	public List<MemberVO> getMemberList(MemberVO m) {
		return this.sqlSession.selectList("admin_list", m);
	} //검색전후 회원목록

	@Override
	public void editM(MemberVO m) {
		this.sqlSession.update("admin_edit", m);
	} //관리자페이지에서 회원정보 수정

	@Override
	public MemberVO getMem(String join_id_box) {
		return this.sqlSession.selectOne("admin_edit_view", join_id_box);
	}//관리자페이지에서 회원정보 조회

	@Override
	public void delM(String join_id_box) {
		this.sqlSession.delete("am_del", join_id_box);
	}

	@Override
	public void editM_pwd(MemberVO m) {
		this.sqlSession.update("admin_edit_pwd", m);
	}


}
