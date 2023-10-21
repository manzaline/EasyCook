package net.easycook.dao;

import java.util.List;

import net.easycook.vo.HotNewsBoardVO;

public interface HotNewsDAO {

	void insertBoard(HotNewsBoardVO hvo);

	int getTotalCount(HotNewsBoardVO hvo);

	List<HotNewsBoardVO> getBoardList(HotNewsBoardVO hvo);

	HotNewsBoardVO getBoardCont(int hno);

	void updateHit(int hno);

	List<HotNewsBoardVO> getBoardListView();

	void editBoard(HotNewsBoardVO hvo);

	void delBoard(int hno);


}
