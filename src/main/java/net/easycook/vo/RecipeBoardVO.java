package net.easycook.vo;

import lombok.Data;

@Data
public class RecipeBoardVO {

	private int no;
	private String writerid;
	private String title;
	private String videoLink;
	private String imgIndex;
	private String imgFolder;
	private String textPack;
	private int visiter;
	private String regdate;
	private String moddate;
	
	private int startNum;
	private int endNum;
	private String searchType;
	private String searchText;
}
