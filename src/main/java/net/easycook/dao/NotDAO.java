package net.easycook.dao;

import java.util.List;

import net.easycook.vo.NoticeBoardVO;

public interface NotDAO {


	List<NoticeBoardVO> getNotList(NoticeBoardVO nb);

	int getListCount(NoticeBoardVO nb);

}
