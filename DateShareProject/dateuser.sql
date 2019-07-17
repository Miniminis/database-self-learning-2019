
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

create SEQUENCE dateuser_seq 
start with 1 
increment by 1;

select dateuser_seq.currval from dateuser;

drop SEQUENCE dateuser_seq;

desc dateuser;
select * from dateuser;
drop table dateuser;
drop table movie;
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
select * from movie;