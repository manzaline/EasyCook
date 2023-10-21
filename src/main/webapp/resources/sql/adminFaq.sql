create table adminFaq(
 adminfaq_no number(38) primary key --번호
 ,adminfaq_name varchar2(30) --작성자
 ,adminfaq_title varchar2(200) not null --공지제목
 ,adminfaq_cont varchar2(4000) not null --공지내용
 ,adminfaq_date date --공지등록날짜
);

select * from adminFaq
drop table adminFaq;

select adminnfaq_no_seq.nextval from dual
--g_no_seq 시퀀스 생성
create sequence adminfaq_no_seq
start with 1
increment by 1
nocache;