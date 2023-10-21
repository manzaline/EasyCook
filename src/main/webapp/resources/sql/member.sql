create table easycook_member(
	join_id_box varchar2(100) primary key
	, join_email_1_box varchar2(50) not null --메일 아이디
	, join_email_2_box varchar2(100) not null --메일 도메인 주소
	, join_pw_box varchar2(200) not null --암호화 된 비번
	, join_pw_check_box varchar2(200) not null --비번 확인
	, join_name_box varchar2(50) not null --이름
	, join_nickname_box varchar2(100) not null --닉네임
	, join_tel_1_box varchar2(10) not null --폰 번호 첫번째
	, join_tel_2_box varchar2(10) not null
	, join_tel_3_box varchar2(10) not null
	, join_pw_q_box varchar2(100) not null --비밀번호 확인 질문
	, join_pw_q_a_box varchar2(100) not null --비밀번호 확인 질문 답
	, join_post_box_1 varchar2(10) not null --우편번호
	, join_post_box_2 varchar2(100) not null --주소
	, join_post_box_3 varchar2(100) not null --나머지 주소 
	, join_date date --가입날짜
	, join_state int --가입회원이면1, 탈퇴회원이면 2, 관리자 3
	, join_delcont varchar2(4000) --탈퇴사유
	, join_deldate date --탈퇴날짜
);

select * from EASYCOOK_MEMBER;
drop table EASYCOOK_MEMBER

insert into EASYCOOK_MEMBER (join_id_box, join_email_1_box, join_email_2_box, join_pw_box, join_pw_check_box, join_name_box, join_nickname_box, join_tel_1_box, join_tel_2_box, join_tel_3_box, join_pw_q_box, join_pw_q_a_box, join_post_box_1, join_post_box_2, join_post_box_3, join_date, join_state) 
values('test', 'test', 'naver.com', 'test', 'test', '테스트', '닉넴', '010', '1111', '2222', '어머니의 성함은?', '신사임당', '07741', '서울시 강남구 역삼동', '이지쿡빌라 202호', '2021-09-04', 1);

insert into EASYCOOK_MEMBER (join_id_box, join_email_1_box, join_email_2_box, join_pw_box, join_pw_check_box, join_name_box, join_nickname_box, join_tel_1_box, join_tel_2_box, join_tel_3_box, join_pw_q_box, join_pw_q_a_box, join_post_box_1, join_post_box_2, join_post_box_3, join_date, join_state) 
values('admin01', 'admin01', 'hanmail.net', 'admin02', 'admin02', '관리자', '관리자02', '011', '9999', '9999', '아버지의 성함은?', '이순신', '00000', '부산', '000호', '2021-09-06', 3);

insert into EASYCOOK_MEMBER (join_id_box, join_email_1_box, join_email_2_box, join_pw_box, join_pw_check_box, join_name_box, join_nickname_box, join_tel_1_box, join_tel_2_box, join_tel_3_box, join_pw_q_box, join_pw_q_a_box, join_post_box_1, join_post_box_2, join_post_box_3, join_date, join_state) 
values('test04', 'test04', 'hanmail.net', 'test', 'test', '관리자', '관리자01', '011', '9999', '9999', '아버지의 성함은?', '이순신', '00000', '부산', '000호', '2021-09-06', 3);

delete from easycook_member where join_id_box='admin02';

update easycook_member set join_state = 1 where join_id_box='admin111'











