-- JDBC Practice 
--1.EMP 테이블에 새로운 사원 정보를 입력하는 프로그램을 작성해보자.
select * from emp;
desc emp;
insert into emp values (8000, 'MINHEE', 'CEO', null, '19/11/10', 10000, 1000, 60);

--2.EMP 테이블의 모든 데이터를 출력하는 프로그램을 작성해보자.
select * from emp;

--3. EMP 테이블에 서 “SCOTT” 사원의 급여(sal) 정보를 1000으로 바꾸는 프로그램을 작성해보자.
update emp01 set sal=1000 where ename='SCOTT';
select * from emp01;

--4.EMP 테이블에 서 “SCOTT” 이름으로 검색한 결과를 출력하는 프로그램을 작성해보자.
select * from emp where ename='SCOTT';

--5.모든 사원정보를 출력하되 부서정보를 함께 출력하는 프로그램을 작성해보자.
select * from emp e join dept d using (deptno) order by deptno;

