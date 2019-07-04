-- 그룹함수
-- 그룹함수의 결과는 단일행-하나의 로우! --> 단일행 함수 사용 가능
-- 그룹함수는 null 값을 갖는 칼럼을 제외하고 연산진행

select * from emp;
--1. sum(컬럼) : 그룹의 합을 반환

-- 전 직원들의 연봉 총액 
select sum(sal) from emp;

-- 10번부서 소속 직원들의 월 급여 총액
select sum(sal) from emp where deptno=10;

-- 전 직원들의 커미션 총액
select comm from emp; -- 직원들의 커미션 목록 
select sum(comm) from emp; -- 커미션 총액 
-- 커미션을 받지 않는 직원들 -> comm=null or comm=0;
-- 그룹함수는 null 값을 갖는 칼럼을 제외하고 연산진행




--2. avg(컬럼)
-- 전 직원들의 평균 연봉 
select avg(sal) avgSal from emp;
select trunc(avg(sal)) avgSalTrunc from emp;
-- 그룹함수의 결과는 단일행 하나의 컬럼! 
-- 따라서 단일행 함수인 trunc() 를 사용할 수 있다. 

-- 메니저 직급의 평균 연봉 
select trunc(avg(sal)) avgSalTrunc from emp where job='MANAGER';

-- 전 직원들의 평균 커미션 
select avg(comm) avgComm from emp;




--3. count(컬럼이름): row의 개수를 반환 

-- 전체 부서의 수 
select * from dept;
select count (deptno) from dept; 
select count(distinct deptno) from emp;

-- 커미션을 받는 직원들의 수 
select count (comm) from emp where comm>0;

-- 10번부서에 속해있는 직원들의 수 
select count (ename) from emp where deptno=10;

-- 부서 별 사원의 수 
select deptno, count(*)from emp group by deptno order by deptno;



--4. max(): 최대값 반환/ min() : 최소값 반환
select max(sal) maxSal, min(sal) minSal from emp;

--5. stddev()/ variance ()

-- 6. 그룹함수와 단순컬럼 
select ename, max(sal) from emp;
-- max() 함수는 그룹함수이기 때문에 결과값은 항상 단일행! 
-- 따라서 14개의 행을 가지는 ename은 
-- 단일행 결과를 출력하는 max, min 함수와 같이 올 수 없다.



-- 7. group by 절
-- 어떤 컬럼값을 기준으로 그룹함수를 적용! 
-- select 기준 컬럼명, 그룹함수 from 테이블 group by 기준 컬럼명
-- 기준 컬럼명: 별칭이 아닌 진짜 컬럼명을 써야한다.

-- 직무 별 평균 연봉 목록 
select job, trunc(avg(sal)) from emp group by job order by job;

-- 부서 별 사원의 수 목록 
select deptno, count(*) from emp group by deptno order by deptno;
select deptno, max(status), count(*) from emp group by deptno;

-- 부서 별 최대 급여와 최소 급여 
select deptno, max(to_char(sal, 'L999,999')), min(to_char(sal, 'L999,999')) from emp group by deptno;

-- 부서 별로 사원의 수와 커미션을 받는 사원들의 수 
select deptno, count(*), count(comm) from emp group by deptno;

-- 담당 매니저 별 사원의 수 
select mgr, count(*) from emp group by mgr;


-- 8. having 절 : group 에 대한 조건 
select deptno, trunc(avg(sal)) from emp 
group by deptno having trunc(avg(sal))>=2000
order by deptno;

select deptno, max(sal), min(sal) from emp
group by deptno having max(sal) >=2900
order by deptno;
