package net.easycook.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import net.easycook.vo.AdminNoticeVO;

@Repository
public class AdminNotDAOImpl implements AdminNotDAO {

	@Inject
	private SqlSession sqlSession;
	@Override
	public int getListCount(AdminNoticeVO an) {
		return this.sqlSession.selectOne("adnot_count",an);
	}
	@Override
	public List<AdminNoticeVO> getNotList(AdminNoticeVO an) {
		return this.sqlSession.selectList("adnot_list",an);
	}
	@Override
	public void insertNot(AdminNoticeVO an) {
		this.sqlSession.insert("adnot_in",an);
		
	}
	@Override
	public void updateNot(AdminNoticeVO an) {
		this.sqlSession.update("adnot_up",an);
		
	}
	@Override
	public void deleteBoard(int no) {
		this.sqlSession.delete("adnot_del",no);
		
	}
	@Override
	public AdminNoticeVO getNoticeCont(int adminnotice_no) {
		return this.sqlSession.selectOne("adnot_cont",adminnotice_no);
	}
}
