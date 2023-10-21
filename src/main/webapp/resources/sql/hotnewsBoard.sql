create table hotNewsBoard(
	hno number(38) primary key
	,hwriter varchar2(50) not null
	,htitle varchar2(200) not null
	,hcont varchar2(4000)
	,hlink varchar2(200) not null
	,hfile varchar2(80) not null
	,viewcnt number(38) default 0
	,regdate date
);

select * from hotNewsBoard order by hno desc
drop table hotNewsBoard
delete from hotNewsBoard

create sequence hno_seq
start with 1
increment by 1
nocache;

select hno_seq.nextval from dual;
drop sequence hno_seq
