package net.easycook.dao;

import java.util.List;

import net.easycook.vo.RecipeBoardCommentVO;
import net.easycook.vo.RecipeBoardVO;

public interface RecipeBoardDAO {

	void writeRec(RecipeBoardVO rb);

	int getTotalPostings(RecipeBoardVO rb);

	List<RecipeBoardVO> getPostingList(RecipeBoardVO rb);

	void upVisiter(int post);

	RecipeBoardVO getPost(int post);

	void deletePost(int post);

	void editPost(RecipeBoardVO rbv);

	void writeComment(RecipeBoardCommentVO rbc);

	int getTotalComments(int post);

	List<RecipeBoardCommentVO> getCommentList(RecipeBoardCommentVO rbc);

	void deleteComment(int cno);

	List<RecipeBoardVO> getTopRecipe();

	List<RecipeBoardVO> getPostingListById(RecipeBoardVO rb);

	int getTotalPostingsById(RecipeBoardVO rb);

	int getTotalCommentsById(RecipeBoardCommentVO rbc);

	List<RecipeBoardCommentVO> getCommentListById(RecipeBoardCommentVO rbc);

	void deleteCommentByRno(int post);


}
