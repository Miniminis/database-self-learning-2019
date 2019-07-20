/* 회원 */
CREATE TABLE dateuser (
	u_num NUMBER, /* 회원번호 : PRIMARY KEY, ASC*/
	u_id VARCHAR2(40) NOT NULL, /* 회원아이디  */
	u_pw VARCHAR2(16) NOT NULL, /* 회원비밀번호 */
	u_name VARCHAR2(50) NOT NULL, /* 회원이름 */
	u_bday DATE NOT NULL, /* 생년월일 */
	u_regdate DATE default sysdate NOT NULL, /* 회원가입날짜 : default sysdate*/ 
	u_gender CHAR(1) NOT NULL, /* 성별 */
    CONSTRAINT dateuser_u_num_pk PRIMARY KEY(u_num), 
    CONSTRAINT dateuser_u_gender_ck check(u_gender in ('M', 'F'))
);

/* 회원 시퀀스*/
create SEQUENCE dateuser_seq
MINVALUE 0;

select dateuser_seq.currval from dateuser;

drop SEQUENCE dateuser_seq;

desc dateuser;
select * from dateuser;
drop table dateuser;
select dateuser_seq.currval from dateuser;

-- 더미데이터
insert into dateuser (u_num, u_id, u_pw, u_name, u_bday, u_regdate, u_gender) 
values(DATEUSER_SEQ.nextval, 'user1', '111', '유저1', '19/11/11', default, 'M');

insert into dateuser (u_num, u_id, u_pw, u_name, u_bday, u_regdate, u_gender) 
values(DATEUSER_SEQ.nextval, 'user2', '222', '유저2', '19/11/12', default, 'F');

insert into dateuser (u_num, u_id, u_pw, u_name, u_bday, u_regdate, u_gender) 
values(DATEUSER_SEQ.nextval, 'user3', '333', '유저3', '19/11/13', default, 'M');

insert into dateuser (u_num, u_id, u_pw, u_name, u_bday, u_regdate, u_gender) 
values(DATEUSER_SEQ.nextval, 'user4', '444', '유저4', '19/11/14', default, 'F');


select * from dateuser join movie using(u_num);
select * from dateuser;

-------------------------------------------------------------------------------

/* 영화추천 */
CREATE TABLE movie (
	m_num NUMBER, /* 글번호 : pk */
	u_num NUMBER NOT NULL, /* 회원번호 : fk*/
	m_title VARCHAR2(50) NOT NULL, /* 제목 */
	m_content LONG NOT NULL, /* 내용 */
	m_writedate DATE DEFAULT sysdate NOT NULL, /* 작성일시 default sysdate */
	m_path VARCHAR2(255) default '../images/noImg.png' NOT NULL, /* 파일경로 default */
	m_hits NUMBER DEFAULT 0 NOT NULL, /* 조회수 default 0*/
	m_star NUMBER DEFAULT 10 NOT NULL, /* 별점 default 10 */
    CONSTRAINT movie_m_num_pk PRIMARY KEY(m_num),
    CONSTRAINT movie_u_num_fk foreign key(u_num)
    REFERENCES dateuser(u_num),
    CONSTRAINT movie_m_star_ck check (m_star BETWEEN 1 AND 10)
);


/* 영화 시퀀스 */
create sequence movie_seq
MINVALUE 0;

drop sequence movie_seq; 

desc movie;
select * from movie;
drop table movie;

insert into movie (m_num, u_num, m_title, m_content, m_writedate, m_like, m_path, m_hits, m_star) 
values(MOVIE_SEQ.nextval, 2, '제목1', '내용1', default, 1, default, 1, 1); 

insert into movie 
values(MOVIE_SEQ.nextval, 2, '제목3', '내용4', default, default, 'file.jpg', default, 4);

insert into movie 
values(MOVIE_SEQ.nextval, 2, '제목4', '내용5', default, default, default, default, 4);

insert into movie 
values(MOVIE_SEQ.nextval, 2, '제목6', '내용6', default, default, default, default, 1);

insert into movie (m_num, u_num, m_title, m_content) 
values(MOVIE_SEQ.nextval, 2, '제목1', '내용1'); 

insert into movie (m_num, u_num, m_title, m_content) 
values(MOVIE_SEQ.nextval, 2, '제목3', '내용3');

insert into movie (m_num, u_num, m_title, m_content) 
values(MOVIE_SEQ.nextval, 2, '제목2', '내용3');

insert into movie (m_num, u_num, m_title, m_content, m_writedate, m_like, m_path, m_hits, m_star) 
values(MOVIE_SEQ.nextval, 2, '제목1', '내용1', default, 1, default, 1, 1); 


-- 유저 테이블과 조인
select * from dateuser join movie using(u_num);
select * from dateuser;
select * from movie;

commit;

select count(*) from movie;

select m_path, m_title, m_writedate, m_hits, m_like from movie order by m_num desc;


select * from dateuser join movie using(u_num); 
select m_path, m_title, u_name, m_writedate, m_like, m_hits, m_content from dateuser join movie using(u_num) where m_num=13;


/* 영화 좋아요 */
CREATE TABLE m_like (
    u_num NUMBER,
    m_num NUMBER,
    CONSTRAINT m_like_u_num_fk foreign key(u_num)
    REFERENCES dateuser(u_num),
    CONSTRAINT m_like_m_num_fk foreign key(m_num)
    REFERENCES movie(m_num)
);

-------------------------------------------------------------------------------



/* 쪽지 */
CREATE TABLE message (
	m_num NUMBER, /* 글번호 */
	u_num NUMBER NOT NULL, /* 회원번호 */
	m_title VARCHAR2(50) NOT NULL, /* 제목 */
	m_content LONG NOT NULL, /* 내용 */
	m_writedate DATE default sysdate NOT NULL, /* 작성일시 */
	m_to VARCHAR2(40) NOT NULL, /* 받는사람 */
    CONSTRAINT message_m_num_pk PRIMARY KEY(m_num), 
    CONSTRAINT message_u_num_fk FOREIGN KEY(u_num)
    REFERENCES dateuser(u_num)
);

/* message 시퀀스 생성 0부터 시작 */
CREATE SEQUENCE message_seq
MINVALUE 0;

select message_sep.currval from dateuser;

drop SEQUENCE message_seq;


/* 회원테이블과 조인 : 회원번호대신 이름으로 뜨게하기*/
select m_num,d.u_name, m_title, m_content, m_writedate,m_to
from ( select rownum rnum, m_num, u_num, m_title, m_content,m_writedate,m_to 
        from ( select *
               from message m
               order by m.m_num desc)
where rownum <= 3 ) join dateuser d
using(u_num)
where rnum >= 1
;

select * from message;
drop table message;

select u_name
from dateuser join message
using(u_num);

insert into message (m_num, m_title, m_content, m_to) values(message_seq.nextval,'안녕하세요', 'ㅎㅇㅎㅇㅎㅇㅎㅇ내용', 'dahee');

select * from message where m_num=28;

delete message where m_num = 27;

-------------------------------------------------------------------------------

/* 맛집 */
CREATE TABLE food (
   f_num NUMBER, /* 글번호 */
   u_num NUMBER NOT NULL, /* 회원번호 */
   f_title VARCHAR2(50) NOT NULL, /* 제목 */
   f_content LONG NOT NULL, /* 내용 */
   f_writedate DATE NOT NULL, /* 작성일시 */
   f_path VARCHAR2(255) default 'image/defaultImg.jpg' NOT NULL, /* 파일경로 */
   f_hits NUMBER NOT NULL, /* 조회수 */
   f_star NUMBER NOT NULL, /* 별점 */
   CONSTRAINT food_f_num_pk PRIMARY KEY(f_num), 
   CONSTRAINT food_u_num_fk FOREIGN KEY(u_num)
   REFERENCES dateuser(u_num),
   CONSTRAINT food_f_star_ck check (f_star BETWEEN 1 AND 10)
);


/* 맛집 시퀀스 */
CREATE SEQUENCE food_seq
MINVALUE 0;

-------------------------------------------------------------------------------



/* 액티비티 */
CREATE TABLE activity (
   a_num NUMBER, 
   u_num NUMBER NOT NULL, 
   a_title VARCHAR2(50) NOT NULL, 
   a_content LONG NOT NULL, 
   a_writedate DATE NOT NULL, 
   a_path VARCHAR2(255) default 'image/defaultImg.jpg' NOT NULL, 
   a_hits NUMBER NOT NULL,
   a_star NUMBER NOT NULL,
   CONSTRAINT activity_a_num_pk PRIMARY KEY(a_num),
   CONSTRAINT activity_a_num_fk foreign key(u_num)
   REFERENCES dateuser(u_num),
   CONSTRAINT activity_a_star_ck check (a_star BETWEEN 1 AND 10)
);

/* 액티비티 시퀀스 */
CREATE SEQUENCE activity_seq
MINVALUE 0;


-------------------------------------------------------------------------------


/* 액티비티 좋아요  */
CREATE TABLE a_like (
    u_num NUMBER,
    a_num NUMBER,
    CONSTRAINT a_like_u_num_fk foreign key(u_num)
    REFERENCES dateuser(u_num),
    CONSTRAINT a_like_a_num_fk foreign key(a_num)
    REFERENCES activity(a_num)
);


/* 맛집 좋아요  */
CREATE TABLE f_like (
    u_num NUMBER,
    f_num NUMBER,
    CONSTRAINT f_like_u_num_fk foreign key(u_num)
    REFERENCES dateuser(u_num),
    CONSTRAINT f_like_f_num_fk foreign key(f_num)
    REFERENCES food(f_num)
);

-------------------------------------------------------------------------------

select * from dateuser join message using(u_num);
select * from dateuser join food using(u_num);
select * from dateuser join movie using(u_num);
select * from dateuser join activity using(u_num);





