--EMP 테이블과 DEPT 테이블을 이용해서 풀이해 주세요.
select * from emp;

--1. 덧셈연산자를 이용하여 모든 사원에 대해서 $300의 급여 인상을 계산한 후 사원의 이름, 급여, 인상된 급여를 출력하시오.
select ename, sal, sal+300 as promotedSal from emp;

--2. 사원의 이름, 급여, 연간 총 수입을 총 수입이 많은 것부터 작은 순으로 출력하시오, 
--연간 총수입은 월급에 12를 곱한 후 $100의 상여금을 더해서 계산하시오.
select ename, sal, sal*12+100 as AnnualSal from emp order by AnnualSal desc;

--3. 급여가 2000을 넘는 사원의 이름과 급여를 표현, 급여가 많은 것부터 작은 순으로 출력하시오.
select ename, sal from emp where sal > 2000 order by sal desc;

--4. 사원번호가 7788인 사원의 이름과 부서번호를 출력하시오.
select ename, deptno from emp where empno=7788;

--5. 급여가 2000에서 3000 사이에 포함되지 않는 사원의 이름과 급여를 출력하시오.
select ename, sal from emp where not (sal between 2000 and 3000);

--6. 1981년 2월 20일 부터 1981년 5월 1일 사이에 입사한 사원의 이름, 담당업무, 입사일을 출력하시오.
select ename, job, hiredate from emp where hiredate between '81/02/20' and '81/05/01';

--7. 부서번호가 20 및 30에 속한 사원의 이름과 부서번호를 출력, 이름을 기준(내림차순)으로 영문자순으로 출력하시오.
select ename, deptno from emp where deptno in(20,30) order by ename desc;
select ename, deptno from emp where deptno=20 or deptno=30 order by ename desc;

--8. 사원의 급여가 2000에서 3000사이에 포함되고 부서번호가 20 또는 30인 사원의 이름, 급여와 부서번호를 출력, 이름순(오름차순)으로 출력하시오.
select ename, sal, deptno from emp where (sal between 2000 and 3000) and (deptno in(20,30)) order by ename;
select ename, sal, deptno from emp where (sal between 2000 and 3000) and (deptno=20 or deptno=30) order by ename;

--9. 1981년도에 입사한 사원의 이름과 입사일을 출력하시오. (like 연산자와 와일드카드 사용)
select ename, hiredate from emp where hiredate like '81%';

--10. 관리자가 없는 사원의 이름과 담당 업무를 출력하시오.
select ename, job from emp where mgr is null;

--11. 커미션을 받을 수 있는 자격이 되는 사원의 이름, 급여, 커미션을 출력하되 급여 및 커미션을 기준으로 내림차순 정렬하여 표시하시오.
select ename, sal, comm from emp where comm is not null and comm>0 order by sal desc, comm desc;

--12. 이름의 세번째 문자가 R인 사원의 이름을 표시하시오.
select ename from emp where ename like '__R%';

--13. 이름에 A와 E를 모두 포함하고 있는 사원의 이름을 표시하시오.
-- ename like '%A%E%' : A-E 순서대로 포함하고 있는 이름만 검색
-- 따라서 이 경우, or ename like '%E%A%' 조건도 같이 추가해야 
-- A와 E의 순서에 상관없이 두 문자를 포함한 결과를 출력한다. 
select ename from emp where ename like '%A%E%'or ename like '%E%A%';

-- A와 E를 '순서상관없이' 포함해야하므로 A와 E에 대한 조건을 따로따로 표기해야한다. 
select ename from emp where ename like '%A%'and ename like '%E%';

--14. 담당업무가 CLERK, 또는 SALESMAN이면서 급여가 $1600, $950 또는 $1300이 아닌 사원의 이름, 담당업무, 급여를 출력하시오.
select ename, job, sal from emp where job in('CLERK', 'SALESMAN') and not(sal in(1600, 950, 1300));
select ename, job, sal from emp where (job='CLERK' or job='SALESMAN') and not(sal=1600 or sal=950 or sal=1300);

--15. 커미션이 $500 이상인 사원의 이름과 급여 및 커미션을 출력하시오.
select ename, sal, comm from emp where comm>=500;

