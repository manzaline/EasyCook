package net.easycook.vo;

import lombok.Data;

@Data
public class NoticeBoardVO {

	private String no_num;
	private String no_name;
	private String no_title;
	private String no_cont;
	private String no_date;

//페이징
	private int startrow;//시작행번호
	private int endrow;//끝행번호

//검색
	
	private String find_field;
	private String find_name;

}