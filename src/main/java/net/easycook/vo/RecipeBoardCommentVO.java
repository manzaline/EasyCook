package net.easycook.vo;

import lombok.Data;

@Data
public class RecipeBoardCommentVO {

	private int cno;
	private int rno;
	private String cwriterid;
	private String cont;
	private String regdate;

	private int startNum;
	private int endNum;
	private String searchText;
	
	private String ptitle;
}
