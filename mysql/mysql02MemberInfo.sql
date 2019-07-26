-- MemberInfo Table 

-- 테이블 생성
create table memberinfo (
	idx int(7) not null auto_increment,
	userid varchar(12) not null, 
    userpw varchar(16) not null,
    username varchar(20) not null,
    userphoto varchar(255) default '/image/noImg.png',
    regdate datetime default CURRENT_TIMESTAMP,
    constraint memberinfo_idx_pk PRIMARY KEY (idx),
    constraint memberinfo_userid_uk unique key (userid)
);

-- 테이블 데이터 확인 
desc memberinfo;
select * from memberinfo;
drop table memberinfo;

insert into memberinfo values(null, "minis@minis", "1111", "손민희", null, now());
insert into memberinfo values(null, "munu@munu", "1111", "순무누", null, now());
insert into memberinfo values(null, "mama3", "1111", "손민희2", null, now());
insert into memberinfo values(null, "mama10", "1111", "손민희10", null, now());



select * from memberinfo;
desc memberinfo;

select count(*) from memberinfo;

select * from memberinfo order by idx desc limit 0, 3;

delete from memberinfo where idx=11;
select * from memberinfo;

select userid, userpw, username, userphoto, regdate from memberinfo where userid="1@1" and userpw ="1"; 

drop table memberinfo;

select * from memberinfo where userid="minis";


