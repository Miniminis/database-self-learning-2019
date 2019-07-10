select * from memberinfo;
desc memberinfo;

insert into memberinfo (idx, userid, userpw, username, userphoto, regdate) 
values (memberinfo_idx.nextval, 'minhee', '1234', '미니미니쓰', null, null);

insert into memberinfo (idx, userid, userpw, username, userphoto) 
values (memberinfo_idx.nextval, 'mini', '5677', '미니', null);

select * from memberinfo where userid='5@5' and userpw=5555;