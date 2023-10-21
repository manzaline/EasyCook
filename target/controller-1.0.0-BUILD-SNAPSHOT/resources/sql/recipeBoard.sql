--레시피 게시판 : 게시글
create table recipeBoard(
	no number(38) primary key,
	writerid varchar2(14) not null,
	title varchar2(80) not null,
	videoLink varchar2(200),
	imgIndex varchar2(20) not null,
	imgFolder varchar2(58) not null,
	textPack varchar2(4000),
	visiter number(30) default 0,
	regdate varchar2(20) not null,
	moddate varchar2(20) not null
);

drop table recipeBoard;

select * from recipeboard order by no desc;

delete from recipeboard;

--recipeBoard 시퀀스
create sequence rb_seq
start with 1
increment by 1
nocache;

select rb_seq.nextval from dual;

alter sequence rb_seq increment by 1;

select count(*) from recipeBoard where title like '%%'

select * from
(select rowNum rNum, no, writerid, title, videoLink, imgIndex, imgFolder, textPack, visiter, regdate, moddate 
from (select * from RECIPEBOARD where title like '%%' order by no desc))
where rNum >= 1 and rNum <= 8


--레시피 게시판 : 댓글
create table recipeBoardComment(
	cno number(38) primary key,
	rno number(38) not null,
	cwriterid varchar2(14) not null,
	cont varchar2(2000) not null,
	regdate varchar2(20) not null,
	constraint recipeBoardComment_rno_fk foreign key(rno) references recipeBoard(no)
)

drop table recipeBoardComment

select * from recipeBoardComment

--recipeBoardComment 시퀀스
create sequence rbc_seq
start with 1
increment by 1
nocache;

select rbc_seq.nextval from dual

alter sequence rbc_seq increment by 1;

select * 
from (select rowNum rNum, cwriterid, cont, regdate 
		from(select * from RECIPEBOARDCOMMENT where rno=500))
where rNum >= 1 and rNum <= 10


select * 
from (select rowNum rNum, cwriterid, cont, regdate 
		from(select * from RECIPEBOARDCOMMENT where rno=500 order by cno desc))
where rNum >= 1 and rNum <= 10

alter table recipeBoard
modify(videoLink varchar2(200))

select * from
(select no, title, imgindex, imgfolder, visiter from recipeBoard order by visiter desc)
where rownum <= 3;

select count(*) from recipeBoard where writerid like 'yym' and title like '%백종%';

select * 
from (select rowNum rNum, r.no rno, r.title ptitle, c.cno, c.regdate, c.cont 
		from (select * from RECIPEBOARD r, RECIPEBOARDCOMMENT c
	where r.no = c.rno and c.cwriterid = 'yym' and c.cont like '%%' order by c.cno desc))
	
where rNum >= 1 and rNum <= 10

select *
from(
	select rowNum rNum, rno, ptitle, cno, regdate, cont
	from(
		select r.no rno, r.title ptitle, c.cno, c.regdate, c.cont
		from(
			select *
			from RECIPEBOARDCOMMENT
			where cwriterid = 'yym' and cont like '%%') c,
			RECIPEBOARD r
		where r.no = c.rno
		order by cno desc
		)
	)
where rNum >= 1 and rNum <= 10