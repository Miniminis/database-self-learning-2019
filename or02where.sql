-- select의 조건절: select 컬럼명 from 테이블 몇 where 조건식(true/false);
-- where 의 조건은 행을 찾는다! 

-- 1. 숫자 비교연산
select dname from dept where deptno = 10; -- 결과: accounting 

select * from emp where deptno = 10; -- 10번 부서에 있는 직원들의 전체 정보 출력 
select empno, ename, job from emp where deptno =10;
-- 10번 부서 내에서 사원번호, 사원이름, 직무를 컬럼으로 하는 표를 생성 

-- 2. 문자, 날짜 비교 연산 
select * from emp where ename = 'scott';
select empno, job from emp where ename = 'SCOTT';
 -- 데이터는 대소문자 구분하므로 반드시 ''안에 대소문자 구분할것
 
select ename, sal, hiredate from emp where hiredate= '81/09/08';
select ename, sal, hiredate from emp where hiredate > '81/09/08' order by hiredate;
 -- 날짜 비교의 경우 ' ' 작은 따옴표 안에 넣어서 비교 
 
-- 3. 논리연산: and, or, not, between~and, in(a,b,c);
-- and, or 
select * from emp where hiredate>'81/09/08' and deptno=30;
select * from emp where hiredate>'81/09/08' or deptno=30;

--or, not 
select * from emp where deptno=10 or deptno=20;
select * from emp where not deptno=30;

--between ~ and : 연봉이 2000이상 3000이하인 직원들 리스트 
select * from emp;
select * from emp where sal >=2000 and sal<=3000 order by sal;
select * from emp where sal between 2000 and 3000 order by sal;

select * from emp where sal >2000 and sal<3000 order by sal;

-- between ~ and: 87년도 입사자 리스트 
select * from emp where hiredate between '87/01/01' and '87/12/31';

--in(a,b,c): or 조건이 많을때 사용 
select * from emp where comm in (300, 500, 1400);

-- 4. like, 와일드카드%,  와일드카드_, not like;
