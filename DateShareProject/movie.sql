/* 영화추천 */
CREATE TABLE movie (
	m_num NUMBER, /* 글번호 : pk */
	u_num NUMBER NOT NULL, /* 회원번호 : fk*/
	m_title VARCHAR2(50) NOT NULL, /* 제목 */
	m_content LONG NOT NULL, /* 내용 */
	m_writedate DATE DEFAULT sysdate NOT NULL, /* 작성일시 default sysdate */
	m_like NUMBER DEFAULT 0 NOT NULL, /* 추천 defualt 0 */
	m_path VARCHAR2(255) default 'image/defaultImg.jpg' NOT NULL, /* 파일경로 default */
	m_hits NUMBER DEFAULT 0 NOT NULL, /* 조회수 default 0*/
	m_star NUMBER DEFAULT 10 NOT NULL, /* 별점 default 10 */
    CONSTRAINT movie_m_num_pk PRIMARY KEY(m_num),
    CONSTRAINT movie_u_num_fk foreign key(u_num)
    REFERENCES dateuser(u_num),
    CONSTRAINT movie_m_star_ck check (m_star BETWEEN 1 AND 10)
);

create sequence movie_seq
start with 1 
increment by 1;

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