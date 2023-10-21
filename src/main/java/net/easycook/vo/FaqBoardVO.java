package net.easycook.vo;

import lombok.Data;

@Data
public class FaqBoardVO {

	private String faq_num;
	private String faq_name;
	private String faq_title;
	private String faq_cont;
	private String faq_day;
	
	//페이징
	private int startrow;//시작행번호
	private int endrow;//끝행번호
	//검색
	
	private String find_field;
	private String find_name;
}
