package net.easycook.vo;

import lombok.Data;

@Data
public class MemberVO {

	private String join_id_box;
	private String join_email_1_box;
	private String join_email_2_box;
	private String join_pw_box;
	private String join_pw_check_box;
	private String join_name_box;
	private String join_nickname_box;
	private String join_tel_1_box;
	private String join_tel_2_box;
	private String join_tel_3_box;
	private String join_pw_q_box;
	private String join_pw_q_a_box;
	private String join_post_box_1;
	private String join_post_box_2;
	private String join_post_box_3;
	private String join_date; //가입날짜
	private int join_state; //가입회원 1, 탈퇴회원2, 관리자 3
	private String join_delcont; //탈퇴사유
	private String join_deldate; //탈퇴날짜
	
	//관리자 회원목록에서 사용할 페이징 변수
	private int startrow; //시작행 번호
	private int endrow; //끝행 번호
	
	//관리자 회원목록 검색필드와 검색어 관련변수
	private String find_field; //검색필드
	private String find_name; //검색어
}
