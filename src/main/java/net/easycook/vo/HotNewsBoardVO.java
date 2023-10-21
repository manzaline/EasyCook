package net.easycook.vo;

import lombok.Data;

@Data
public class HotNewsBoardVO {

	private int hno;
	private String hwriter;
	private String htitle;
	private String hcont;
	private String hlink;
	private String hfile;
	private int viewcnt;
	private String regdate;
	
	private int startrow;
	private int endrow;
	
	private String find_field;
	private String find_name;	

}
