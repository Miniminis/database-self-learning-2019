-- GUEST BOOK DDL 
--테이블 생성
CREATE TABLE GUESTBOOK_MESSAGE (
    MESSAGE_ID NUMBER(6) CONSTRAINT GB_MID_PK PRIMARY KEY, --NOTNULL, UNIQUE 속성 포함 
    GNAME VARCHAR2(50) NOT NULL,
    GPASSWORD VARCHAR2(20) NOT NULL,
    GMESSAGE long NOT NULL
);

--시퀀스 생성
CREATE SEQUENCE GM_MID_SEQ START WITH 1 INCREMENT BY 1;

--테이블 확인 
select * from guestbook_message;
DROP TABLE GUESTBOOK_MESSAGE;

--insert() 를 위한 쿼리문 작성 
--insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, ?,?,?);


insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini01','111','방명록!');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini02','222','방명록222');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini03','333','방명록3');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini04','444','방명록4');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini05','555','방명록5');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini06','666','방명록6');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini07','777','방명록7');
insert into guestbook_message (message_id, gname, gpassword, gmessage) values (GM_MID_SEQ.nextval, 'mini08','888','방명록8');

-- inline view && rownum 써서 상위 특정 개수의 데이터만 가져오기 
select * from guestbook_message order by rownum;


