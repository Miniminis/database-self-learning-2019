-- 서브 쿼리 sub query 
-- 조인 가능 --> 서브 쿼리 
-- 서브 쿼리 --> 조인 가능
-- 하지만 서브쿼리는 성능 이슈 주의! 

-- 1. 단일행 

-- 1-1. SCOTT 사원이 소속된: 서브쿼리 --> 조건! 
-- 부서 이름을 출력 : 메인쿼리 
select dname from dept 
where deptno = (select deptno from emp where ename='SCOTT');

-- 부속질의 팁: () 안에 원하는 데이터가 올바르게 출력되었는지 확인을 위해 
-- 서브쿼리 밖에서 먼저 확인한 후, 대입하는 방식으로 진행!
select deptno from emp where ename ='SCOTT'; -- 위의 메인 쿼리에 대입! 


-- 1-2. 사원들 중, 평균 급여보다 많은 급여를 받는  -- 서브쿼리
-- 사원의 이름과 급여를 출력!                      -- 메인쿼리 
select ename, sal from emp where sal > (select avg(sal) from emp);

-- 1-3. 예제 : 서브쿼리를 이용하여 'CLARK' 교수와 동일한 직책의 사원 이름을 검색하세요.
select ename from emp where job = (select job from emp where ename = 'CLARK');

-- 2. 다중행 

-- 2-1. in 연산자 
-- 급여가 3000이상인 사원의 소속 부서 -- 서브쿼리 
-- 해당 부서의 부서원 리스트 -- 메인쿼리 
select ename, sal from emp 
where deptno in (select distinct deptno from emp where sal>=3000) 
order by sal;

-- 2-2. All 연산자 : 모든 결과값과 값이 일치하면 참 
--      >All: 서브쿼리의 최댓값보다 크면 참 
select ename, sal from emp where sal> all (select sal from emp where deptno=30);

-- 2-3. Any 연산자: 하나라도 일치하면 참 
--      >Any: 서브쿼리의 최솟값보다 크면 참 
select ename, sal from emp where sal >any (select sal from emp where deptno=30);

-- 3. 부속질의 
-- 3-1. 인라인 뷰 : from 절 뒤에 서브쿼리가 위치 - 결과값이 테이블 형태! 
-- 가상 테이블 형태!!!!! 
select * from (select empno, ename, job, hiredate from emp);
-- emp 테이블이 아닌, 가상테이블 select 절 에서 전체 정보를 출력하고 있다! 
-- sal 컬럼을 뺀 나머지 컬럼만 사원들에게 보여주고자 할때 

-- 3-2. 스칼라 부속질의: select 절에 서브쿼리 위치 
-- 성능 이슈 주의! 
select ename, deptno,(
    select dname 
    from dept 
    where dept.deptno=emp.deptno) 
from emp;

-- 스칼라 부속질의 이용해서 사원이름, 메니저이름 같이 출력하기 
select ename, mgr, (select ename from emp m where e.mgr=m.empno) mname 
from emp e;
