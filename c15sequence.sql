-- sequence: 자동 숫자 증가 처리해주는 객체

-- sequence 생성 
create sequence test_seq;

-- nextval: 새로운 sequence 값을 생성 
select TEST_SEQ.nextval from dual;
-- currval: 현재 sequence 값을 확인
select TEST_SEQ.currval from dual;

-- sequence 값을 삭제 
drop sequence test_seq;


-- sequence 범위 생성 
create sequence test_seq2 
start with 10 
increment by 10;

select test_seq2.nextval from dual;
select test_seq2.currval from dual;

drop sequence test_seq2;


-- 기존 테이블에 sequence 값 넣어주기 
select * from emp;
select * from memberinfo;
