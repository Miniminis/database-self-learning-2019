-- 2019.07.11 GUESTBOOK DDL

drop table GUESTBOOK_MESSAGE;

CREATE TABLE GUESTBOOK_MESSAGE (
    MESSAGE_ID int(6) PRIMARY KEY auto_increment,
    GUEST_NAME VARCHAR(50) NOT NULL,
    PASSWORD VARCHAR(20) NOT NULL,
    MESSAGE text NOT NULL
);
select * from guestbook_message;

INSERT INTO GUESTBOOK_MESSAGE (GUEST_NAME, PASSWORD, MESSAGE) values ("minhee","1111","다녀가요~!");


select rownum, messge_id, guest_name from GUESTBOOK_MESSAGE order by messge_id desc;

