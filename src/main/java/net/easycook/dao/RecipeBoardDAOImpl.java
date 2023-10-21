package net.easycook.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import net.easycook.vo.RecipeBoardCommentVO;
import net.easycook.vo.RecipeBoardVO;

@Repository
public class RecipeBoardDAOImpl implements RecipeBoardDAO {

	@Autowired
	private SqlSession sqlSession;

	@Override
	public void writeRec(RecipeBoardVO rb) {
		sqlSession.insert("ins_rb", rb);
	}

	@Override
	public int getTotalPostings(RecipeBoardVO rb) {
		return sqlSession.selectOne("get_total", rb);
	}

	@Override
	public List<RecipeBoardVO> getPostingList(RecipeBoardVO rb) {
		return sqlSession.selectList("get_rb_list", rb);
	}

	@Override
	public void upVisiter(int post) {
		sqlSession.update("upVis", post);
	}

	@Override
	public RecipeBoardVO getPost(int post) {
		return sqlSession.selectOne("get_Post", post);
	}

	@Override
	public void deletePost(int post) {
		sqlSession.delete("del_post", post);
	}

	@Override
	public void editPost(RecipeBoardVO rbv) {
		sqlSession.update("edit_post", rbv);
	}

	@Override
	public void writeComment(RecipeBoardCommentVO rbc) {
		sqlSession.insert("ins_comment", rbc);
	}

	@Override
	public int getTotalComments(int post) {
		return sqlSession.selectOne("get_totalComments", post);
	}

	@Override
	public List<RecipeBoardCommentVO> getCommentList(RecipeBoardCommentVO rbc) {
		return sqlSession.selectList("get_rbc_list", rbc);
	}

	@Override
	public void deleteComment(int cno) {
		sqlSession.delete("del_comment", cno);
	}

	@Override
	public List<RecipeBoardVO> getTopRecipe() {
		return sqlSession.selectList("get_top3recipe");
	}

	@Override
	public List<RecipeBoardVO> getPostingListById(RecipeBoardVO rb) {
		return sqlSession.selectList("get_rbList_id", rb);
	}

	@Override
	public int getTotalPostingsById(RecipeBoardVO rb) {
		return sqlSession.selectOne("get_total_id", rb);
	}

	@Override
	public int getTotalCommentsById(RecipeBoardCommentVO rbc) {
		return sqlSession.selectOne("get_totalC_id", rbc);
	}

	@Override
	public List<RecipeBoardCommentVO> getCommentListById(RecipeBoardCommentVO rbc) {
		return sqlSession.selectList("get_rbcList_id", rbc);
	}

	@Override
	public void deleteCommentByRno(int post) {
		sqlSession.delete("del_comment_rno", post);
	}

	
}
