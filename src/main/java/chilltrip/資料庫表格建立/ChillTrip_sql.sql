CREATE DATABASE IF NOT EXISTS tia104g2;

USE tia104g2;

drop table IF EXISTS member;
drop table IF EXISTS trip_comment;

-- 行程留言表 --
CREATE TABLE trip_comment (
    trip_comment_id INT(11) NOT NULL AUTO_INCREMENT COMMENT '行程留言ID',
    member_id INT(11) NOT NULL COMMENT '會員ID',
    trip_id INT(11) NOT NULL COMMENT '行程ID',
    score INT(1) NOT NULL COMMENT '評分',
    photo LONGBLOB COMMENT '照片',
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
    content LONGTEXT NOT NULL COMMENT '留言內容',
    CONSTRAINT pk_trip_comment_id PRIMARY KEY (trip_comment_id)
--     CONSTRAINT fk_trip_comment_member_id FOREIGN KEY (member_id) REFERENCES member(member_id),
--     CONSTRAINT fk_trip_comment_trip_id FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
) COMMENT '行程留言表';


insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('1','1','5',null,'2024-12-01 15:30:45','這個行程太讚了吧!好想馬上照著行程去玩~');
insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('2','1','4',null,'2024-12-01 12:30:45','我也想要照這個行程安排旅行');
insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('3','1','4',null,'2024-12-01 13:30:45','好想馬上出發去旅遊哦~');

-- 一般用戶表 --
CREATE TABLE member (
member_id			INT(11) NOT NULL AUTO_INCREMENT COMMENT '會員ID',
email			    VARCHAR(20) NOT NULL COMMENT '電子信箱',
account			    VARCHAR(20) NOT NULL COMMENT '帳號',
password			VARCHAR(15) NOT NULL COMMENT '密碼',
name			    VARCHAR(10) NOT NULL COMMENT '姓名',
phone			    VARCHAR(15) NOT NULL COMMENT '聯絡電話',
status			    INT(1) NOT NULL COMMENT '帳號狀態 (0: 一般狀態, 1: 黑名單)',
create_time			TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '帳號建立時間',
nick_name			VARCHAR(15) NOT NULL COMMENT '會員名稱',
gender			    INT(1) NOT NULL COMMENT '性別 (0: 男性, 1: 女性)',
birthday			DATE COMMENT '生日',
company_id			VARCHAR(8) COMMENT '公司統編',
E_receipt_carrier	VARCHAR(20) COMMENT '手機載具',
credit_card         VARCHAR(19) COMMENT '信用卡號',
tracking_number     INT(10) COMMENT '追蹤數',
fans_number         INT(10) COMMENT '粉絲數',
photo               LONGBLOB COMMENT '照片',
CONSTRAINT pk_member_id PRIMARY KEY (member_id)
-- CONSTRAINT uk_email UNIQUE (email),
-- CONSTRAINT uk_account UNIQUE (account),
-- CONSTRAINT uk_phone UNIQUE (phone)
)COMMENT ' 一般用戶表';

 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('seal@abc.com', 'seal123','seal456','seal','0952123456','0','2024-12-01 08:00:00','seal','1');
 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('yuki@abc.com', 'yuki123','yuki456','yuki','0952123457','0','2024-12-01 09:00:00','yuki','1');
 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('et@abc.com', 'et123','et456','et','0952123458','0','2024-12-01 10:00:00','eatting','0');
