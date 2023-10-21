package net.easycook.dao;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import net.easycook.vo.NoticeBoardVO;

@Repository
public class NotDAOImpl implements NotDAO {
	@Inject
	private SqlSession sqlSession;


	@Override
	public List<NoticeBoardVO> getNotList(NoticeBoardVO nb) {
		return this.sqlSession.selectList("Not_list",nb);
	}


	@Override
	public int getListCount(NoticeBoardVO nb) {
		return this.sqlSession.selectOne("Not_co",nb);
	}

}
