package net.easycook.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

import net.easycook.dao.HotNewsDAO;
import net.easycook.vo.HotNewsBoardVO;

@Service
public class HotNewsServiceImpl implements HotNewsService {

	@Autowired
	private HotNewsDAO hotNewsDAO;

	@Override
	public void insertBoard(HotNewsBoardVO hvo) {
		this.hotNewsDAO.insertBoard(hvo);
	}

	@Override
	public int getTotalCount(HotNewsBoardVO hvo) {
		return this.hotNewsDAO.getTotalCount(hvo);
	}

	@Override
	public List<HotNewsBoardVO> getBoardList(HotNewsBoardVO hvo) {
		return this.hotNewsDAO.getBoardList(hvo);
	}

//	@Transactional(isolation = Isolation.READ_COMMITTED) //트랜잭션 격리 => 트랜잭션이 처리되는 중간에 외부 간섭을 없앰.
	@Override
	public void getBoardCont(int hno) {
		this.hotNewsDAO.updateHit(hno);
//		return this.hotNewsDAO.getBoardCont(hno); 
	}

	@Override
	public HotNewsBoardVO getBoardCont2(int hno) {
		return this.hotNewsDAO.getBoardCont(hno);
	}//조회수증가 뺴고 내용만 보기

	@Override
	public List<HotNewsBoardVO> getBoardListView() {
		return this.hotNewsDAO.getBoardListView();
	}

	@Override
	public void editBoard(HotNewsBoardVO hvo) {
		this.hotNewsDAO.editBoard(hvo);
	}

	@Override
	public void delBoard(int hno) {
		this.hotNewsDAO.delBoard(hno);
	}
}
