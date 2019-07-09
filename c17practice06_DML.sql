-- practice 06 DML
select * from book;
select * from customer;
select * from orders;

--1 마당서점의고객이요구하는다음질문에대해SQL 문을작성하시오.
--(5) 박지성이구매한도서의출판사수
select count(publisher) from book 
where bookid in (select bookid from orders o join customer c using(custid) where name='박지성');

--(6) 박지성이구매한도서의이름, 가격, 정가와판매가격의차이
select bookname, abs(price-saleprice) Pricegap 
from orders o join book b 
using(bookid) 
where o.custid = (select custid from customer where name='박지성');

--(7) 박지성이구매하지않은도서의이름
select bookname from book 
where bookid not in (select bookid from orders o, customer c where o.custid=c.custid and c.name='박지성');


-- 부적절한 데이터: 아래와 같이 진행하게 되면, 주문이 된 도서에 한정하여 테이블이 만들어지기 때문에 
-- 적절한 데이터 출력이 될 수 없다. 
--select distinct bookname 
--from orders o join book b 
--using(bookid)
--where o.custid in (select custid from customer where name!='박지성');


--2 마당서점의운영자와경영자가요구하는다음질문에대해SQL 문을작성하시오.
--(8) 주문하지않은고객의이름(부속질의사용)
select name from customer where custid not in (select distinct custid from orders);

--(9) 주문금액의총액과주문의평균금액
select sum(saleprice) Total, avg(saleprice) AvgSalePrice from orders;

--(10) 고객의이름과고객별구매액
select name, sum(saleprice) from orders o join customer c using(custid) group by name;

--(11) 고객의이름과고객이구매한도서목록 -- customer name, order bookid, book bookname   
select name, bookname 
from (select * from orders o, customer c, book b where o.custid=c.custid and o.bookid = b.bookid) 
order by name;

--(12) 도서의가격(Book 테이블)과판매가격(Orders 테이블)의차이가가장많은주문
select * from orders o join book b on o.bookid=b.bookid 
where abs(price-saleprice)>= all(
    select abs(price-saleprice) 
    from (select * from orders o, customer c, book b where o.custid=c.custid and o.bookid = b.bookid));

--(13) 도서의판매액평균보다자신의구매액평균이더높은고객의이름
--select * from orders o, customer c, book b where o.custid=c.custid and o.bookid = b.bookid;
--select name, avg(saleprice) from orders o, customer c where o.custid=c.custid group by name;

select name 
from customer c join orders o 
on c.custid= o.custid 
group by name
having avg(saleprice) > (select avg(price) from book b, orders o where b.bookid=o.bookid);
  
--3. 마당서점에서 다음의 심화된 질문에 대해 SQL 문을 작성하시오.
--(1) 박지성이 구매한 도서의 출판사와 같은 출판사에서 도서를 구매한 고객의 이름

select name from orders o, customer c, book b where o.custid=c.custid and o.bookid = b.bookid
and publisher in (
    select publisher 
    from orders o natural join book b 
    where custid = (select custid from customer where name='박지성'))
and name != '박지성';

--(2) 두 개 이상의 서로 다른 출판사에서 도서를 구매한 고객의 이름
select name from orders o, customer c, book b where o.custid=c.custid and o.bookid = b.bookid
group by name
having count(distinct publisher)>=2;

--4 다음질의에대해DML 문을작성하시오.
--(1) 새로운도서(‘스포츠세계’, ‘대한미디어’, 10000원)이마당서점에입고되었다.
--    삽입이안될경우필요한데이터가더있는지찾아보자.
--(2) ‘삼성당’에서출판한도서를삭제해야한다.
--(3) ‘이상미디어’에서출판한도서를삭제해야한다. 삭제가안될경우원인을생각해보자.
--(4) 출판사‘대한미디어’가‘대한출판사’로이름을바꾸었다.