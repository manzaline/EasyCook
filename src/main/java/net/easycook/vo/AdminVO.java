package net.easycook.vo;

import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
public class AdminVO {
	
	//페이징
	private int startrow;
	private int endrow;
	
	//검색
	private String find_field;
	private String find_name;
}
