-- GUESTBOOK DDL
-- 게시물 정보를 저장할 테이블 생성 
CREATE TABLE GUESTBOOK_MESSAGE (
    MESSAGE_ID int(6) PRIMARY KEY auto_increment,
    GUEST_NAME VARCHAR(50) NOT NULL,
    PASSWORD VARCHAR(20) NOT NULL,
    MESSAGE text NOT NULL
);

desc guestbook_message;

drop table guestbook_message;

-- 생성된 테이블 확인 
select * from guestbook_message;

-- 테이블 리스트 출력을 위한 확인용 dummy 데이터 삽입 
INSERT INTO GUESTBOOK_MESSAGEguestbook_message (GUEST_NAME, PASSWORD, MESSAGE) values ("minhee","1111","다녀가요~!111");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("jb","2222","나는 잠이 더 필요해22");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("yj","333","나는 잠이 더 필요해333");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("gg","groomy","나는 잠이 더 필요해444");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("55","55555","나는 잠이 더 필요해555");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("66","666666","나는 잠이 더 필요해666666");
INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("77","777777","나는 잠이 더 필요해777");


-- 테이블 리스트 3행씩 출력을 위한 쿼리문 작성 
-- limit 시작점, 출력개수
select * from testdb.guestbook_message order by message_id desc limit 0, 3;
select * from testdb.guestbook_message order by message_id desc limit ?, ?;



select * from guestbook_message order by message_id desc limit 0, 3;

insert into GUESTBOOK_MESSAGE values (null, "minhee2", "1111", "방명록써여 ");

insert into GUESTBOOK_MESSAGE values (null, "dd", "222", "dd?");

SELECT * FROM guestbook_message;

