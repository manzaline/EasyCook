package net.easycook.vo;

import lombok.Data;

@Data
public class AdminNoticeVO {

		private int adminnotice_no;
		private String adminnotice_name;
		private String adminnotice_title;
		private String adminnotice_cont;
		private String adminnotice_date;
		
		//페이징
		private int startrow;//시작행번호
		private int endrow;//끝행번호
		//검색
		
		private String find_field;
		private String find_name;
	}

