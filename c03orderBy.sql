-- Order By 정렬 

select * from emp;

-- ASC: 오름차순 정렬(default)
select * from emp order by sal asc;
select * from emp order by sal;
select * from emp order by hiredate; -- 입사일이 가장 빠른 사람부터 정렬 

-- DESC: 내림차순 정렬 
select * from emp order by sal desc;
select * from emp order by hiredate desc; 
-- 입사일이 가장 늦은 사람부터 정렬 
-- = 입사일이 가장 최근인 사람부터 정렬

-- 여러가지 정렬 조건의 결합 
-- 연봉이 적은 순서대로 출력하되, 이름이 같은 사원의 경우 입사일이 먼저인 사람을 먼저 정렬 
select * from emp order by sal, hiredate;
-- 결과: WARD	SALESMAN	7698	81/02/22	1250
--      MARTIN	SALESMAN	7698	81/09/28	1250
--      FORD	ANALYST	    7566	81/12/03	3000
--      SCOTT	ANALYST	    7566	87/04/19	3000

select * from emp order by sal, ename;
--MARTIN	SALESMAN	7698	81/09/28	1250
--WARD	    SALESMAN	7698	81/02/22	1250

select * from emp order by sal; 
-- default 정렬기준 : empno 
--7788	SCOTT	ANALYST	7566	87/04/19	3000		20
--7902	FORD	ANALYST	7566	81/12/03	3000		20


