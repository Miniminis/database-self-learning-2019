-- 가상 테이블 view: 사용자에게 보여지는 가상 테이블 
-- 특정 컬럼을 제외하거나 복잡한 sql 문을 간소화 
-- 자주 사용하는 테이블 구조를 가상테이블 view 의 형태로 저장해 호출을 용이하게 함 
select * from emp;

create or replace view emp_view30
as (select empno, ename, job, deptno from emp where deptno=30);
-- ORA-01031: 권한이 불충분합니다: SYS 계정에서 SCOTT 에게 권한 부여 

select empno, ename, job, deptno from emp where deptno=30;
select * from emp_view30;


-- 1. 인라인 뷰 
-- 일회성 출력: 인라인 뷰 이용 
-- 다회성 출력: view 정의 후, 편하게 호출 
-- 1-1. inline-view: 사원 중에서 입사일이 빠른 사람 5명(TOP-5)만을 얻어 오는 질의문을 작성해 봅시다.
-- 1) rownum 이용하여 줄세우기
-- 2) rowmun 1-5번까지에 해당하는 사람만 출력 
select ename, hiredate from (select * from emp order by hiredate) where rownum <6;

-- * mysql : hiredate 으로 정렬 후, limit 0, 5
--select * from emp limit 0, 5;

-- 1-2. view: 사원 중에서 입사일이 빠른 사람 5명(TOP-5)만을 얻어 오는 질의문을 작성해 봅시다.
-- 1) view 를 생성함으로서 rownum을 hiredate 순서로 정렬 
create or replace view emp_view_hd
as select * from emp order by hiredate;

select * from emp_view_hd; 

-- 2) 새롭게 정렬된 뷰를 통해 top5 구하기 
select ename, hiredate from emp_view_hd where rownum <6;


