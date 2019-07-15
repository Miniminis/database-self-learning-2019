-- practice

select * from emp;



create or replace view vw_emp
as (select empno, ename, job from emp);