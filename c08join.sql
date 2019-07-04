-- join : 2개 이상의 테이블을 옆으로 붙인다! 
-- 표현하는 컬럼이 늘어난다! 
-- 데이터의 집합(로우*컬럼)*데이터의 집합(로우*컬럼)
-- 테이블을 붙인다: cross join : 경우의 수 형태로 표현됨 


-- 1. equi join
select * from emp, dept order by dept.deptno;
-- 아무 조건이 없이 두 개의 테이블을 합쳤기 때문에 
-- 기본 emp 테이블에 dept 테이블의 요소들을 하나씩 경우의 수 형태로 추가하였다. 
-- 전체 컬럼: emp colum+ dept colum = 8+3 = 11
-- 전체 로우: emp row 14 * dept row 4 = 56

-- 7839	KING	PRESIDENT		81/11/17	5000		10	10	ACCOUNTING	NEW YORK
-- 위의 결과값에서 보면 emp table의 deptno=10 인 경우와, dept table의 deptno=10 인 경우, 즉, 
-- empt.deptno = dept.deptno 인 경우가 진짜 데이터이므로, 해당 조건을 join 시에 넣어주면 
-- 원하는 데이터를 얻을 수 있다! 
select * from emp, dept where emp.deptno = dept.deptno order by dept.deptno;

-- 이름이 'SCOTT'인 사원의 이름과 부서이름을 출력! 
-- 테이블에 별칭 부여! from 절 다음에 emp e, dept d 
--> 그 이후로는 계속 별칭 사용하여 문장 출력 가능
select ename, dname 
from emp e, dept d 
where e.deptno=d.deptno and 
ename ='SCOTT';

-- 주문 테이블에서 회원의 이름과 주문 정보 출력! 
select * from orders o, customer c
where o.custid = c.custid 
and name='박지성';


-- 세 개의 테이블 join 하기 : customer, book, orders 
-- 5 * 10 * 10 행 = 500행 
--> 조건 추가하여 유효한 데이터 출력: 
-- 1) orders.custid = customer.custid : 고객이름 일치 조건 
-- 2) and orders.bookid=book.bookid; : 책 이름 일치 조건 
-- 세 개의 테이블을 연결하므로 두 개의 외래키를 이용해서 테이블을 접착! 
select orderid, orderdate, name, bookname, b.price 
from orders o, customer c, book b
where o.custid=c.custid and (o.bookid=b.bookid);

-- 박지성 고객이 주문한 책의 이름을 출력 
select bookname, publisher
from customer c, orders o, book b
where o.custid=c.custid 
and o.bookid=b.bookid
and name='박지성';






-- 2. non-equi join
-- 조인 조건: 특정 범위 내에 있는지 조사 
-- where 절에 비교 연산자 사용 
select * from salgrade;
select * from emp, salgrade;

select ename, sal, grade
from emp, salgrade
where sal between losal and hisal;
--and ename='SMITH';




-- 3. self join : 자기 자신과 조인을 맺는 테이블  
-- 테이블의 이름이 같기 때문에 반드시 식별자가 필요하다. 
select * from emp employee, emp manager;

select employee.ename, manager.ename from emp employee, emp manager
where employee.mgr = manager.empno
order by employee.ename;


select employee.ename || '의 매니저는 '|| manager.ename from emp employee, emp manager
where employee.mgr = manager.empno
order by employee.ename;








-- 4. outer join : 조인 조건을 만족하지 못해도 해당 열을 출력해주고 싶을때 
-- null 값이 존재할 수 있는 조건 뒤에 (+) 기호 추가 - null 데이터를 추가! 
-- 밑의 경우: 출력의 대상은 employee 목록, 
-- manager 는 존재하지 않을 수도 있기 때문에 manager.empno(+);
select employee.ename, manager.ename 
from emp employee, emp manager
where employee.mgr = manager.empno(+);
order by employee.ename;
-- 결과: KING	(null)



-- 5. ansi cross join: mysql, oracle 등 모든 데이터베이스 프로그램에서 사용 가능한 join 키워드 
SELECT * FROM EMP CROSS JOIN DEPT;
select * from emp, dept;

-- 6. ansi inner join
-- FROM 기준테이블 INNER JOIN 조인 대상 테이블 ON 조인 조건 WHERE 다른 추가 조건(필요시)
-- JOIN 에서 조인 조건은 반드시 ON을 통해 표현하도록 한다. 
-- 조인 조건 이외의 추가 조건은 WHERE 절을 통해 표현함
SELECT * FROM EMP INNER JOIN DEPT
ON EMP.DEPTNO=DEPT.DEPTNO
WHERE ENAME='SCOTT';

select * from emp, dept 
where emp.deptno=dept.deptno
and ename='SCOTT';

-- USING 이용하여 공통컬럼 한번만 출력
SELECT * FROM EMP INNER JOIN DEPT 
USING(DEPTNO);

-- NATURAL JOIN 이용하여 공통컬럼 한번만 출력
SELECT * FROM EMP NATURAL JOIN DEPT;

-- LEFT OUTER JOIN 
SELECT * 
FROM EMP E LEFT OUTER JOIN EMP M 
ON E.MGR=M.EMPNO;

-- RIGHT OUTER JOIN 
-- 고객 리스트 주문정보와 함께 출력 
SELECT * 
FROM ORDERS O RIGHT OUTER JOIN CUSTOMER C
ON O.CUSTID=C.CUSTID;
