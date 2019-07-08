-- MemberInfo table DML 
select * from MemberInfo;
desc memberinfo;
--이름        널?       유형           
----------- -------- ------------ 
--IDX       NOT NULL NUMBER(7)    
--USERID    NOT NULL VARCHAR2(12) 
--USERPW    NOT NULL VARCHAR2(16) 
--USERNAME  NOT NULL VARCHAR2(20) 
--USERPHOTO          VARCHAR2(30) 
--REGDATE            DATE 

-- insert: 암시적 null 값 대입 
insert into memberinfo (idx, userid, userpw, username, userphoto) values (memberinfo_idx.nextval, 'dahee123', '12345', '강다희', '');
insert into memberinfo (idx, userid, userpw, username, userphoto) values (memberinfo_idx.nextval, 'shotgun00', '00000', '정건', null);

insert into memberinfo (idx, userid, userpw, username) values (memberinfo_idx.nextval, 'shark03', 'scary!!!', '상어');


-- insert: 명시적 null 값 대입 
insert into memberinfo values(memberinfo_idx.nextval, 'sundubu', '4566', '임두부', 'dubu.jpg', sysdate);
insert into memberinfo values(memberinfo_idx.nextval, 'helloOracle!', 'oracle!', '오라클', null, sysdate);

select * from memberinfo;

-- update: 이름, 비밀번호, 사진 수정 
-- where 기준점: PK 기준! 

-- 사용자 이름만 수정 
update memberinfo set username = '손다희' where idx=2;
--where username='강다희';


-- 사용자 비밀번호, 사진 동시에 수정 
update memberinfo 
set userpw = (select ename from emp where ename='SMITH'), 
userphoto=(select job from emp where ename='SMITH') 
--where username='정건';
where idx=3;

-- delete : 사용자 정보 삭제하기
-- where 기준점: PK 기준! 
delete from memberinfo where idx=1;
select * from memberinfo;


-- 데이터 수정 완료 후 --> 커밋: 물리적 저장!!!!!!!!
commit;

delete from memberinfo where idx=4;
commit; -- 한 트랜잭션 저장 
rollback; -- 한 커밋 전으로 이동 
select * from memberinfo;


------------------------------------------
-- sequence 생성 
------------------------------------------
-- 회원 가입시 증가하는 idx 값을 위한 sequence 생성 
create sequence memberinfo_idx;
