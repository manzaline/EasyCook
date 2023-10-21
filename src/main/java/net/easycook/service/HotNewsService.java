package net.easycook.service;

import java.util.List;

import net.easycook.vo.HotNewsBoardVO;

public interface HotNewsService {

	void insertBoard(HotNewsBoardVO hvo);

	int getTotalCount(HotNewsBoardVO hvo);

	List<HotNewsBoardVO> getBoardList(HotNewsBoardVO hvo);

	void getBoardCont(int hno);

	HotNewsBoardVO getBoardCont2(int hno);

	List<HotNewsBoardVO> getBoardListView();

	void editBoard(HotNewsBoardVO hvo);

	void delBoard(int hno);

}
