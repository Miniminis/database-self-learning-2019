-- SQL 주요 함수 

-- 1. DUAL TABLE: 단 1개의 컬럼으로 이루어짐
desc dual;
select * from dual;
-- 결과: row X 출력

-- 2. 숫자 함수
select * from emp;

--floor() : 소수점 아래 버림
select floor(empno/2) from emp;

--round(): 특정 자릿수에서 반올림 
select round(empno/2, 0) from emp;

-- 3. 문자처리함수 
-- 4. 날짜함수
-- 5. 형변환 함수: TO_NUMBER, TO_CHAR, TO_DATE
-- 5-1. TO_CHAR(날짜데이터, '문자출력형식'): 날짜형-> 문자형
select sysdate from dual;
select sysdate, to_char(sysdate, 'YYYY-MM-DD') from dual;

select hiredate, to_char(hiredate, 'yyyy.mm.dd') as "DATE" from emp;
-- 80/12/17	1980.12.17
select hiredate, to_char(hiredate, 'yyyy"년 "mon dd"일"') from emp;
-- 80/12/17	1980년 12월 17일
select hiredate, to_char(hiredate, 'yyyy.mm.dd day') from emp;
-- 80/12/17	1980.12.17 수요일
select hiredate, to_char(hiredate, 'yyyy.mm.dd dy') from emp;
-- 80/12/17	1980.12.17 수

select sysdate, to_char(sysdate, 'yyyy/mm/dd, hh24:mi:ss') from dual;
-- 19/07/03	2019/07/03, 16:49:02

-- 5-2. TO_CHAR(숫자데이터, '문자출력형식'): 숫자형-> 문자형
select ename, sal, 
    to_char(sal, 'L999,999') as charsal, 
    to_char(sal*12, 'L999,999') as Annualsal,
    to_char(sal*12+nvl(comm, 0), 'L999,999') as Annualsalwithcomm
    from emp;
-- ALLEN	1600	           ￦1,600	          ￦19,200	          ￦19,500
-- L: 통화표시
-- 999,999: 자릿수 표시, 자릿수 안맞을 경우 표시 안함 
select ename, sal, to_char(sal, 'L000,000') as charSAL from emp;
-- ALLEN	1600	         ￦001,600
-- 000,000: 자릿수 표시, 자릿수 안맞을 경우 0으로 표시함 

-- 5-3. TO_DATE (숫자타입, 'yyyymmdd')
select ename, hiredate, to_date(19810220, 'yyyymmdd') 
from emp 
where hiredate = to_date(19810220, 'yyyymmdd');
-- 숫자타입 19810220 -> 날짜타입 81/02/20

-- 5-3. TO_DATE (문자타입, 'yyyymmdd')
select ename, hiredate, to_date('19810220', 'yyyymmdd') 
from emp 
where hiredate = to_date('1981-02-20', 'yyyy-mm-dd');
-- '1981-02-20'형태로 들어오는 값을 각 자리를 기준으로 yyyy-mm-dd로 읽어서 처리!

-- 5-4. TO_DATE() 함수를 이용한 날짜 계산 
select sysdate, sysdate-to_date('1994/08/11', 'yyyy/mm/dd') from dual;
select sysdate, trunc(sysdate-to_date('1994/08/11', 'yyyy/mm/dd')) from dual;

-- 6. DECODE(표현식, 조건1, 결과1, 조건2, 결과2, 기본결과): switch, case 형식과 유사! 
-- 조건이 일치(=비교연산자)하는 경우에 대해서만 적용됨
select ename, deptno, 
    decode(deptno, 10, 'ACCOUNTING',
                    20, 'RESEARCH',
                    30, 'SALES', 
                    40, 'OPERATION')
    as dname
from emp;

-- 6-1. decode()함수를 이용한 직급에 따른 연봉인상 
select empno, ename, job, sal, 
    decode(job, 
            'ANALYST', sal*1.05,
            'SALESMAN', sal*1.1,
            'MANAGER', sal*1.15,
            'CLERK', sal*1.2
            ) upsal 
from emp;


-- 7. CASE 함수: if else 와 유사한 구조
-- decode() 함수와 다르게 다양한 비교연산자를 이용해 조건을 제시할 수 있다. 
select ename, deptno, 
    case when deptno=10 then 'ACCOUNTING'
        when deptno=20 then 'RESEARCH'
        when deptno=30 then 'SALES'
        when deptno=40 then 'OPERATIONS'
        else 'no name'
    end as dname
from emp;


