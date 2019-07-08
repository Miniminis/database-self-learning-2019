-- DML 
-- 1. �뜲�씠�꽣 �엯�젰
-- inser into �뀒�씠釉붾챸(而щ읆 由ъ뒪�듃...) values (�엯�젰 �뜲�씠�꽣 由ъ뒪�듃...)

-- 2. �뀒�씠釉� �궘�젣 
drop table dept01;

-- 3. �뀒�씠釉� �깮�꽦
-- 而щ읆 援ъ“留� 媛��졇�삤湲�! - �뜲�씠�꽣 �젣�쇅 
create table dept01 as select * from dept where 1=0;
desc dept01;

-- 1-1. �뜲�씠�꽣 �엯�젰 
insert into dept01 (deptno, dname, loc) values (10, 'ACCOUNTING', 'SEOUL');
select * from dept01;

-- 1-2. �뜲�씠�꽣 �엯�젰: 而щ읆紐� �깮�왂 
insert into dept01 values (20, 'ANALYSIS', 'BUSAN');

-- 1-3. null 媛� �엯�젰
-- 諛⑸쾿 1) �븫�떆�쟻: 而щ읆紐낆쓣 湲곗닠�븯吏� �븡�쓬 
-- 諛⑸쾿 2) 紐낆떆�쟻: values 媛믪뿉 null �쓣 紐낆떆�쟻�쑝濡� ���엯
-- 諛⑸쾿 3) 紐낆떆�쟻: values 媛믪뿉 ''�쓣 紐낆떆�쟻�쑝濡� ���엯 
insert into dept01 (deptno, dname) values (30, 'SALES');
-- 寃곌낵:  30	    SALES	(null)

insert into dept01 values(40, 'OPERATIONS', null);
insert into dept01 values(50, 'MARKETING', '');
-- 40	OPERATIONS	null
-- 50	MARKETING	null 


-- 1-5. �꽌釉� 荑쇰━ �씠�슜�븯�뿬 �뜲�씠�꽣 �궫�엯 
insert into dept01 select * from dept;
select * from dept01;

-- 1-6. insert all
-- �떎以묓뀒�씠釉붿뿉 �떎以묓뻾 �궫�엯 : �룞�떆 �엯�젰! - 鍮덈룄�닔 �궙�쓬

-- 2. update ~ set: �뀒�씠釉� �닔�젙 
-- where �젅 X: 紐⑤뱺 �뻾 �닔�젙 
-- where + 議곌굔: 議곌굔�뿉 �빐�떦�븯�뒗 �듅�젙 �뻾留� �닔�젙 

select * from emp01;
drop table emp01;
create table emp01 as select * from emp;

-- 전체 테이블 대상 업데이트  
update emp01 set deptno=50;
update emp01 set sal = sal*1.1;

-- 특정 행 대상 업데이트: (feat. 스미뜨 하고 싶은거 다해~!)
update emp01 set sal = sal*5 where ename='SMITH';
select * from emp01;

-- 2-1.부서번호가 10번인 사원의 부서번호를 30번으로 수정합시다.
update emp01 set deptno = 30 where deptno=10;

-- 2-2. 급여가 3000 이상인 사원만 급여를 10% 인상합시다.
update emp01 set sal = sal*1.1 where sal >= 3000;

-- 2-3. 그간 고생한 SMITH 사원만 임금 2배 인상 
update emp01 set sal = sal*2 where ename='SMITH';

-- 2-4. 1987년에 입사한 사원의 입사일 --> 오늘로 수정
update emp01 set hiredate = sysdate where hiredate between '87/01/01' and '87/12/31';
update emp01 set hiredate = '19/08/11' where substr(hiredate, 0, 2) = '19';

-- 2-5. SMITH 사원의 부서번호는 20번으로, 직급은 MANAGER로 한꺼번에 수정하도록 합시다.
select * from emp01;
update emp01 set deptno=50, job='MANAGER' where ename='SMITH';

-- 2-6. SCOTT 사원의 입사일자는 오늘로, 급여를 50 으로 커미션을 4000 으로 수정합시다.
update emp01 set hiredate=sysdate, sal=50, comm=4000 where ename='SCOTT';

-- 2-7. 서브쿼리를 이용한 데이터 업데이트 
-- 20번 부서의 지역명을 40번 부서의 지역명으로 변경하기 위해서 서브 쿼리문을 사용해 봅시다.
drop table dept01;
create table dept01 as select * from dept;
select * from dept01;

update dept01 set loc = (select loc from dept where deptno=40) where deptno=20;
-- 스칼라 부속질의: 단일행, 단일열

-- 2-8. 부서 번호가 20번인 부서의 이름과 지역은 RESEARCH와 DALLAS입니다. 
-- 다음은 부서번호가 20인 부서의 부서명과 지역명을 
-- 부서 번호가 30번인 부서와 동일하게 변경하기 위한 UPDATE 명령문입니다.
update dept01 set (dname, loc) = (select dname, loc from dept where deptno=30) where deptno=20;

-- 3. Delete : delete 문으로 행 삭제 
-- where 절: 조건에 해당하는 행 단위 삭제 

select * from dept01;

-- 테이블 전체 로우 삭제 
delete from dept01;

drop table dept01;
create table dept01 as select * from dept;
select * from dept01;

-- 테이블 특정 행 삭제: where 절 이용 
delete from dept01 where deptno=30;
select * from dept01;

-- 컨텐츠/서비스 회사들: 회원들이 탈퇴하나다고 하더라도 쉽게 정보를 삭제 처리하지 않음 

-- 사원 테이블에서 부서명이 SALES인 사원을 모두 삭제해봅시다.
delete from emp01 where deptno = (select deptno from dept01 where dname='SALES');
select * from emp01;