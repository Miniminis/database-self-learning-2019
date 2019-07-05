-- DDL : Data Definition Language 

-- 1. create table: 테이블 생성- 컬럼, 데이터 저장 규칙을 직접 정의 
-- (컬럼 이름, 저장 데이터 타입, 저장 데이터 사이즈, 제약조건 )
-- null/not null
-- unique - 중복여부
-- default - 기본값 
-- 체크 
-- pk - 기본키  
-- fk - 외래키 

create table emp01 ( -- 테이블 이름: emp01 
    empno number(4), -- 컬럼이름은 empno인 저장공간: 숫자, 4자리 
    ename VARCHAR2(20), -- 컬럼 이름은 ename 인 저장공간: 가변문자, 20자리(영문기준) 
    sal number(7,2) -- 컬럼 이름은 sal 인 저장공간: 숫자, 7자리
);


-- 1-2. create table: 테이블 생성- 서브 쿼리 이용 
-- 테이블과 그 속의 데이터까지 다 가져오지만, 제약조건은 가져오지 않는다. 
create table emp02 
as select * from emp;
desc emp02;

-- 1-3. 기존 테이블 중 일부 컬럼만 가져와 신규 테이블 생성하기 
create table emp03 
as select empno, ename, job, hiredate from emp;
desc emp03;

-- 1-4. 기존 테이블 중 특정 조건에 맞는 행만 가져와 신규 테이블 생성하기
create table emp04 
as select * from emp
where deptno=20;
select * from emp04;

-- 1-5. 테이블 구조만 복사하고 싶을때, where 절에 false 조건  
create table emp05 
as select * from emp 
where 1=2;
select * from emp05;





-- [Member Manager Project] MemberInfo table 생성하기 
create table MemberInfo(
    userid varchar2(12), -- 아이디: 영문 최대 12자리 
    userpw varchar2(16), -- 비밀번호: 영문 최대 16자리 
    username varchar2(20), -- 이름: 한글 10자리 = 20바이트  
    userphoto varchar2(30), -- 사진: 30자리 문자열 
    regDate date default ''
    --regDate TIMESTAMP(6) WITH TIME ZONE
);
select * from MemberInfo;






-- 2. drop table 테이블 이름: 테이블 삭제 
drop table MemberInfo;




-- 3. alter table: 테이블 수정
-- add column : 맨 뒤에 추가됨, 기존 테이블에서 해당 컬럼값은 null 표시. 
select * from emp01;
desc emp01;

alter table emp01 add (job VARCHAR2(9));

-- modify column : 기존 컬럼을 새로운 컬럼으로 정의 하는 방식 - 덮어쓰기! 
alter table emp01 modify (job varchar2(14));

-- drop column : 컬럼 제거 
alter table emp01 drop column job;




-- 4. trucate table : 테이블의 구조만 남기고 데이터만 삭제 
select * from emp02;
truncate table emp02;
-- Table EMP02이(가) 잘렸습니다.


-- 5. rename: 테이블 이름 바꾸기 
rename emp02 to test; 
-- 테이블 이름이 변경되었습니다.
desc emp02;
select * from emp02;
-- ORA-00942: 테이블 또는 뷰가 존재하지 않습니다
desc test;
select * from test;




-- 6. 테이블의 무결성 제약조건 
-- not null
-- unique
-- primary key : not null && unique
-- foreign key : 참조하는 컬럼 존재 유무 
-- check 

create table emp06 (
    -- empno number(4) not null unique,                 -- unique : 중복값 불허용 
    empno number(4) primary key,                        -- PK 설정 : not null && unique 
    ename varchar2(20) not null,                        -- not null: null 값 불허용 
    sal number(7, 2) default 1000,                      -- default: 기본값 설정 
    -- grade number(1) check (grade>0 and grade<6)
    grade number(1) check (grade between 1 and 5),      -- check: 값의 유효성 체크 
    --gender char(1) check (gender='M' or gender='W')
    gender char(1) check (gender in('M', 'W')),
    deptno number(2) references dept(deptno)
    --foreign key (deptno) references dept(deptno) -- foreign key 설정 
);

desc emp06;
select * from emp06;
drop table emp06;

-- insert into 테이블 이름 (컬럼 리스트) values (값, 값, 값, 값....) 
-- 값: 컬럼 순서대로 입력하는 것이 중요! 
-- 컬럼의 개수 == values 값 개수
-- 자료형 일치! 
insert into emp06 (empno, ename) values (null, null); -- empno: not null 제약조건
insert into emp06 (empno, ename) values (2011, null); 
insert into emp06 (empno, ename) values (2011, 'king'); -- empno : unique 제약 조건 
-- ORA-00001: 무결성 제약 조건(SCOTT.SYS_C0011061)에 위배됩니다
insert into emp06 (empno, ename) values (2012, 'king'); 
insert into emp06 (empno, ename) values (2013, 'smith'); 
insert into emp06 (empno, ename, sal) values (2014, 'SMITH', 5000); 

insert into emp06 values (1988, 'flash', null, 5, 'W'); -- 전체 데이터 입력: 컬럼부분 () 생략 가능
insert into emp06 values (1988, 'flash', null, 5, 'W'); -- 무결성 제약조건 위배 
insert into emp06 values (1989, 'flash', null, 9, 'W'); -- 체크 제약조건 위배 
insert into emp06 values (1990, 'flash', null, 3, 'K'); -- 체크 제약조건 위배 
insert into emp06 values (2000, 'puky', 6000, 5, 'W', 70); -- 무결성 제약조건 위배: 부모키 부재 
insert into emp06 values (2000, 'puky', 6000, 5, 'W', 30);

select * from emp06;



--------------------------
create table emp07(
    empno number(4) constraint emp07_empno_nn not null, -- null 값은 해당 행에서만 정의 가능 
    ename varchar2(10) constraint emp07_ename_nn not null, -- null 값은 해당 행에서만 정의 가능 
    job varchar2(9),
    deptno number(2), 
    constraint emp07_empno_pk primary key(empno), -- 테이블 정의 하단에서 제약조건을 일괄 처리 할때에는 반드시 (컬럼명) 처리!  
    constraint emp07_job_uk unique(job),
    constraint emp07_deptno_fk foreign key (deptno) references dept(deptno) -- foreign key (외래키) references 참조 테이블명(참조 테이블 컬럼명 - pk);
);


--------MemberInfo Table 
-- 대리키: idx                 --  기본키       
-- 아이디: 6-12 자리 문자열     -- not null, unique 
-- 비밀번호: 8-16자리 문자열     -- not null
-- 이름: 10자리 문자열         -- not null 
-- 사진경로(파일이름): 30자리 문자열 
-- 가입날짜: 날짜타입           -- default sysdate 

create table MemberInfo(
    idx number(7), 
    userid varchar(12) constraint MemberInfo_userid_nn not null,
    userpw varchar(16) constraint MemberInfo_userpw_nn not null,
    username varchar(20) constraint MemberInfo_username_nn not null,
    userPhoto varchar(30),
    regDate date default sysdate,
    constraint MemberInfo_idx_pk primary key(idx),
    constraint MemberInfo_userid_uk unique(userid)    
);
select * from MemberInfo;
insert into MemberInfo values(1, null, '1234', '손흥민', null, null);
-- ORA-01400: NULL을 ("SCOTT"."MEMBERINFO"."USERID") 안에 삽입할 수 없습니다
-- constraint 를 이용해서 제약조건을 명시해주면, 에러가 나더라도 어떤 컬럼에서 발생했는지 명확하게 알 수 있다. 
