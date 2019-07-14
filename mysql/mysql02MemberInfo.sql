-- MemberInfo Table 

-- 테이블 생성
create table memberinfo (
	
	userid varchar(12) not null, 
    userpw varchar(16) not null,
    username varchar(20) not null,
    userphoto varchar(30), 
    regdate datetime default CURRENT_TIMESTAMP
);

-- 테이블 데이터 확인 
desc memberinfo;
select * from memberinfo;
select * from memberinfo where ;

