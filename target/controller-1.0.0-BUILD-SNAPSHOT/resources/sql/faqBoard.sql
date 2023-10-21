--faq작성
create table faqBoard(
	faq_num number(38) primary key
	,faq_name varchar2(38) not null
	,faq_title varchar2(38) not null
	,faq_cont varchar2(3800) not null
	,faq_date date
);

drop table faqBoard
select * from faqBoard

create sequence faq_num_seq
	start with 1
	increment by 1
	nocache;

select adminfaq_no_seq.nextval from dual;