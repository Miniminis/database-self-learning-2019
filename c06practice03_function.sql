-- SQL 함수 practice 03
select * from emp;

--16. SUBSTR 함수를 사용하여 사원들의 입사한 년도와 입사한 달만 출력하시오.
-- substr(대상문자, '자를 시작점', '자리수')
select substr(hiredate, '0', '5') from emp;

--17. SUBSTR 함수를 사용하여 4월에 입사한 사원을 출력하시오.
select ename from emp where substr(hiredate, '4', '2')='04';

--18. MOD 함수를 사용하여 사원번호가 짝수인 사람만 출력하시오.
-- MOD(대상숫자, 나눌수) = 나머지 값 출력
select ename from emp where mod(empno, 2)=0;

--19. 입사일을 년도는 2자리(YY), 월은 숫자(MON)로 표시하고 요일은 약어 (DY)로 지정하여 출력하시오.
select to_char(hiredate, 'yy mon dd dy') from emp;

--20. 올해 몇 칠이 지났는지 출력하시오. 
--현재날짜에서 올해 1월 1일을 뺀 결과를 출력하고 
--TO_DATE 함수를 사용하여 데이터 형을 일치*** 시키시오.
select trunc(sysdate-to_date('2019/01/01', 'yyyy/mm/dd')) from dual;

--21. 사원들의 상관 사번을 출력하되 상관이 없는 사원에 대해서는 NULL 값 대신 0으로 출력하시오.
select ename, nvl(mgr,0) from emp;

--22. DECODE 함수로 직급에 따라 급여를 인상하도록 하시오. 
-- 직급이 ‘ANALIST”인 사원은 200, ‘SALESMAN’인 사원은 180, ‘MANAGER’인 사원은 150, ‘CLERK”인 사원은 100을 인상하시오.
select ename, job, sal, 
    decode(job, 
            'ANALYST', sal+200,
            'SALESMAN', sal+180,
            'MANAGER', sal+150,
            'CLERK', sal+100) upsal 
from emp;




select ename, job, sal, 
    case 
        when job='ANALYST' then sal+200
        when job='SALESMAN' then sal+180
        when job='MANAGER' then sal+150
        when job='CLERK' then sal+100
    end as upsal
from emp;


--- *** 추가 문제
--23. 모든 사원의 급여 최고액, 최저액, 총액 및 평균 급여를 출력하시오. 
-- 평균에 대해서는 정수로 반올림하시오.
select max(sal), min(sal), sum(sal), round(avg(sal)) from emp;

--24. 각 담당 업무 유형별로 급여 최고액, 최저액, 총액 및 평균 액을 출력하시오. 
-- 평균에 대해서는 정수로 반올림 하시오.
select job, max(sal), min(sal), sum(sal), round(avg(sal)) 
from emp group by job;

--25. COUNT(*) 함수를 이용하여 담당업무가 동일한 사원 수를 출력하시오.
select job, count(*) totalempnum from emp group by job;

--26. 관리자 수를 나열하시오.
select count(distinct mgr) numofmgr from emp;

--27. 급여 최고액, 급여 최저액의 차액을 출력하시오.
select max(sal)-min(sal) as salGap from emp;

--28. 직급별 사원의 최저 급여를 출력하시오. 
-- 관리자를 알 수 없는 사원 제외
-- 최저 급여가 2000 미만인 그룹은 제외시키고 
-- 결과를 급여에 대한 내림차순으로 정렬하여 출력하시오.
select * from emp;
select job, min(sal) from emp 
where mgr is not null
group by job
having min(sal)>=2000
order by min(sal) desc;

--29. 각 부서에 대해 부서번호, 사원 수, 부서 내의 모든 사원의 평균 급여를 출력하시오. 
-- 평균 급여는 소수점 둘째 자리로 반올림 하시오.
select deptno, count(ename) as totalempnum, round(avg(sal), 2) avgsal 
from emp 
group by deptno 
order by deptno;

--30. 각 부서에 대해 부서번호 이름, 지역 명, 사원 수, 부서내의 모든 사원의 
-- 평균 급여를 출력하시오. 평균 급여는 정수로 반올림 하시오. DECODE 사용.
select * from dept;
select * from emp;

---------join 사용 
select emp.deptno, dname, loc, count(*), round(avg(sal)) 
from emp, dept 
where emp.deptno = dept.deptno
group by emp.deptno, dname, loc
order by emp.deptno;

------ join 미사용 
select deptno,
decode(deptno, 
        10, 'ACCOUNTING',
        20, 'RESEARCH', 
        30, 'SALES',
        40, 'OPERATIONS')부서이름,
decode(deptno, 
        10, 'NEW YORK',
        20, 'DALLAS',
        30, 'CHICAGO',
        40, 'BOSTON') 지역명,
count(*) 총직원수,
round(avg(sal)) 평균급여 
from emp
group by deptno
order by deptno;

--31. a. 업무를 표시한 다음 
-- b. 해당 업무에 대해 부서 번호별 급여 및 
-- c. 부서 10, 20, 30의 급여 총액을 각각 출력하시오. 
-- 별칭은 각 job, dno, 부서 10, 부서 20, 부서 30, 총액으로 지정하시오. 
-- ( hint. Decode, group by )

-- group by 복수 개의 컬럼 : 각 컬럼의 조건을 충족하는 것이 하나의 그룹!
-- group by 컬럼1, 컬럼2: 컬럼 1과 컬럼2를 모두 만족할 때 하나의 그룹 생성

---------join 사용 


---------join 미 사용 
select job, deptno dno, 
decode(deptno, 10, sum(sal)) 부서10,
decode(deptno, 20, sum(sal)) 부서20,
decode(deptno, 30, sum(sal)) 부서30,
sum(sal)총액
from emp
group by job, deptno
order by dno asc, job asc; 