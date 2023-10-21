--공지사항 작성
create table noticeBoard(
	no_num number(38) primary key --숫자
	,no_name varchar2(30) not null --작성자
	,no_title varchar2(30) not null --제목
	,no_cont varchar2(4000) not null --내용
	,no_date date --등록날짜1
);

drop table noticeBoard;
select * from noticeBoard;

--board_no_seq 시퀀스 생성
create sequence no_num_seq
start with 1 --1부터 시작
increment by 1 --1씩 증가옵션
nocache;

drop sequence board_no_seq;

select no_num_seq.nextval from dual;