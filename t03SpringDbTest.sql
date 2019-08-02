-- Spring DB TEST

Create table user (
	userid varchar(20),
    userpw varchar(30),
    username varchar(16),
    userage varchar(10)
);

select * from user;
desc user;

insert user values("1", "1111", "일번지", "19");
update user set userpw="1111", username="234", userage="12" where userid="2@2";