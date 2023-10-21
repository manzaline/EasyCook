package net.easycook.vo;

import lombok.Data;

@Data
public class AdminFaqVO {

	private int adminfaq_no;
	private String adminfaq_name;
	private String adminfaq_title;
	private String adminfaq_cont;
	private String adminfaq_date;
	
	//페이징
	private int startrow;//시작행번호
	private int endrow;//끝행번호
	//검색
	
	private String find_field;
	private String find_name;

}
