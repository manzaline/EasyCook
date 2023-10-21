package net.easycook.dao;

import java.util.List;

import net.easycook.vo.FaqBoardVO;
import net.easycook.vo.AdminFaqVO;

public interface FaqDAO {

	int getListCount(AdminFaqVO af);

	List<AdminFaqVO> getFaqList(AdminFaqVO af);


}
