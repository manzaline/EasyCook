package net.easycook.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import net.easycook.vo.AdminFaqVO;

@Repository
public class AdminFaqDAOImpl implements AdminFaqDAO {

	@Inject
	private SqlSession sqlSession;
	@Override
	public int getListCount(AdminFaqVO af) {
		return this.sqlSession.selectOne("adfaq_count",af);
	}
	@Override
	public List<AdminFaqVO> getFaqList(AdminFaqVO af) {
		return this.sqlSession.selectList("adfaq_list",af);
	}
	@Override
	public void insertFaq(AdminFaqVO af) {
		this.sqlSession.insert("adfaq_in",af);
		
	}
	@Override
	public AdminFaqVO getfaqCont(int adminfaq_no) {
		return this.sqlSession.selectOne("adfaq_cont",adminfaq_no);
	}
	@Override
	public void updateFaq(AdminFaqVO af) {
		this.sqlSession.update("adfaq_up",af);
		
	}
	@Override
	public void deleteBoard(int no) {
		this.sqlSession.delete("adfaq_del",no);
		
	}

}
