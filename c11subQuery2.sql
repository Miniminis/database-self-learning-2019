-- 서브 쿼리 - 부속질의 2 

-- 1. 스칼라 부속질의 - select 부속질의 
-- 1-1. 고객 이름별 구매 총 금액을 출력 (스칼라 부속질의)
select * from customer;
select * from orders;

select custid, (
    select name 
    from customer c 
    where c.custid = o.custid
    ), -- 결과: 단일행, 단일열  - 해당 custid 에 맞는 이름 하나만 출력! : 각각의 행에 맞는 이름이 출력된다. 
    sum(saleprice) 구매총액 
from orders o 
group by custid;

-- 실행 순서 
-- 1. custid 별 구매 총액의 표시 - group by 
-- 2. orders.custid = customer.custid 인 조건에 맞는 고객 이름을 출력 
-- 행 하나 처리 -- scala 부속질의 실행 : 단일행, 단일 열 

-- 1-1. 고객 이름별 구매 총 금액을 출력 (JOIN)
select o.custid, name, sum(saleprice)
from orders o join customer c
on o.custid=c.custid
group by o.custid, name;

-- 2. 인라인 뷰 
-- 데이터를 뽑는 테이블에서 아예 조건을 한정해주는 경우 
-- 고려할 대상을 처음부터 좁히고 조건에 맞는 테이블에서 원하는 컬럼 출력 
select * 
from customer
where custid <=2;

select * 
from (select * from customer where custid <=2) c, orders o 
where c.custid = o.custid;


-- rownum: 오라클에서 지원해주는 행 번호
-- 입력되는 순서에 따름(정렬 순서가 아님) 
select rownum, empno, ename
from emp
order by ename;

-- 부속질의를 통해 만든 새로운 테이블 
-- from 절에 아예 이름 알파벳 순서대로 정렬된 새로운 테이블을 대입하므로서 
-- rownum 은 쿼리 절의 테이블에서 1-14번 정렬을 하게 된다. 
select rownum, empno, ename
from (select * from emp order by ename);


-- 3. 종속질의 : where 절 
-- 3-1. 평균 주문금액 이하의 주문에 대해서,
-- 주문 번호와 금액을 출력 
select avg(saleprice) from orders; 
-- 11800: 주문이 생길때마다 평균값이 변함 --> 변할때마다 다시 쿼리문을 작성해서 결과값을 기억해야함 

select orderid, saleprice from orders 
where saleprice <= (select avg(saleprice) from orders);

-- 3-2. 각 고객의 평균 주문금액보다 큰 금액의 주문내역에 대해서 주문번호, 고객번호, 
-- 금액을 출력! 
select avg(saleprice) from orders 
where orders.custid = customer.custid;

select orderid, custid, sum(saleprice) 
from orders o
where saleprice >= (select avg(saleprice) from orders c where o.custid = c.custid)
group by orderid, custid;

-- 3-3. 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
-- in() : 다중행+단일열 
select sum(saleprice) 총판매액 
from orders 
where custid in 
(select custid from customer where address like '%대한민국%');

-- 3-3. 조인: 대한민국에 거주하는 고객에게 판매한 도서의 총판매액을 구하시오.
select sum(saleprice) 총판매액 
from orders o, customer c
where o.custid = c.custid and address like '%대한민국%';

select sum(saleprice) 총판매액 
from orders o inner join customer c
on o.custid = c.custid
where address like '%대한민국%';

-- 3-4. 3번 고객이 주문한 도서의 최고 금액보다 더 비싼 도서를 구입한 주문의 
-- 주문번호와 금액을 보이시오.

-- 3번 고객이 주문한 도서들의 금액 
select saleprice from orders where custid=3;

select orderid, saleprice 
from orders
where saleprice > all(select saleprice from orders where custid=3);

select orderid, saleprice 
from orders
where saleprice > (select max(saleprice) from orders where custid=3);

-- 3-5. EXISTS 연산자로 대한민국에 거주하는 고객에게 판매한 
-- 도서의 총 판매액을 구하시오.
select sum(saleprice)
from orders o
where exists (select * from customer c where o.custid = c.custid 
and address like '%대한민국%');