DESC dept; -- 결과: 이름(속성이름), 널?(널 여부) , 유형(데이터타입) 

-- 데이터를 검색하는 명령
-- select(컬럼이름) from (테이블 이름)
-- 결국, select는 기존 테이블에서 컬럼들을 뽑아와 새로운 테이블을 만드는 역할 
select * from dept;
-- 전체 컬럼 출력: deptno, dname, loc 순서(초기 테이블 생성시의 순서);

select deptno from dept;

select deptno, dname from dept; 
-- 모든 부서번호, 부서이름값을 선택하여 받음! 

select dname, loc, deptno from dept;
-- 전체 컬럼을 선택하여 받았지만, 컬럼의 순서는 dname, loc, deptno! 
-------------------------------------------------------------------

DESC emp; -- emp 테이블의 정보 및 구조를 알려줌 
select * from emp; --emp 테이블 전체를 출력 

--사원의 번호와 이름 목록을 emp 테이블에서 출력하고자 할때, 
select empno, ename from emp; 

-- 연봉계산을 위한 테이블 
select ename, sal, sal*12 from emp;

-- 컬럼의 사칙연산 
select sal, comm, sal+comm from emp; 
-- comm 이 null인 경우 연산 자체가 불가하므로 --> 결과는 null 
-- 올바른 월급 계산을 위해서는 null --> 0으로 변환하는 과정이 반드시 필요! 
select ename, sal, nvl(comm, 0), sal+nvl(comm, 0) from emp;

select sal, sal-100 from emp;           -- 감봉 
select ename, sal, sal*12 from emp;     -- 연봉 
select sal, sal/5 from emp;             -- 원천징수 금액: 20% 

select ename, job, sal, comm, nvl(comm, 0), sal*12+comm, sal*12+nvl(comm, 0) ,sal*12+nvl(comm, 0) as Annual from emp;
-- nvl(특정컬럼이름, 치환값) : 특정 컬럼의 값이 null 인 경우 
--특정값(숫자, 문자, 날짜형 등 해당 컬럼이 가지고 있는 데이터 타입)으로 치환해주는 함수 
-- as 바꾸고자 하는 컬럼 이름: 특정 컬럼을 별칭으로 설정하여 출력

--컬럼과 문자열을 연결하는 결과 출력 
select ename || ' is a ' || job from emp;
select ename || ' is a ' || job as job_description from emp;
select ename || ' is a ' || job job_description from emp;
-- sql 에서 문자열 표현은 ' '

-- distinct : 컬럼값에서 중복되는 값을 제거하여 하나의 데이터만 출력 
select distinct job from emp;
select distinct deptno from emp;

select distinct job, deptno from emp;
-- distinct(컬럼1, 컬럼2) 



