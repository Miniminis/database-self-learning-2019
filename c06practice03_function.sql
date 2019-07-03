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