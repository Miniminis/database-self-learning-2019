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
-- like : 문자 패턴 검색 연산자 키워드 
-- 패턴: %, _ : 자리수 고려할때는 '_'를, 아닐때는 '%'를 쓰면 좋을듯!

-- '% 패턴' 이용 
-- 사원 테이블에서 'S'로 시작하는 사원의 이름을 검색 
select * from emp where ename like 'S%';
-- 결과: SMITH, SCOTT (*** 주의: 데이터는 대소문자를 구별함);

-- 사원들 중, 이름에 'A'를 포함하는 사원들의 목록
select * from emp where ename like '%A%';

-- 사원들 중, 입사년도가 1981년인 사원들의 목록 
select * from emp where hiredate like '81%';

-- '_패턴' 이용 : 문자의 자리(위치) 고정을 의미: 해당 자리에는 어떠한 값이 와도 무관! 
-- _A : 앞자리 문자는 어떠한 문자여도 무관, 두번째 문자는 반드시 A 
-- 사원의 이름중에 두번째 문자에 'A'를 포함하는 이름의 사원 + 뒤에는 아무 문자가 와도 상관없음
select * from emp where ename like '_A%';
-- select * from emp where ename like '_A'; : 총 자리수 2글자, 두번째 글자는 A

-- not like 연산자 
-- 사원의 이름중 문자 'A'를 포함하지 않는 사원들 리스트 
select * from emp where ename not like '%A%';


-- 5. null 값 연산 
-- 5-1. IS NULL 
-- 커미션이 없는 사원들의 리스트를 출력하고자 할때 
select * from emp where comm=null;
-- 결과: 아무것도 없음 --> null은 = 연산이 불가

select * from emp where comm is null or comm=0;
-- null: 커미션이 입력되지 않은 것, 
-- 0: 커미션을 받지 않는 것

-- 커미션을 받는 사원들의 리스트 
select * from emp where comm is not null and comm >0;
select * from emp where not (comm is null or comm=0);


