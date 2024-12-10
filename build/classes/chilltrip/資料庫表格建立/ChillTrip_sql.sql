CREATE DATABASE IF NOT EXISTS tia104g2;

USE tia104g2;

drop table IF EXISTS member;
drop table IF EXISTS administrator;
drop table IF EXISTS trip;
drop table IF EXISTS sub_trip;
drop table IF EXISTS location;
drop table IF EXISTS announcement;
drop table IF EXISTS location_comment;
drop table IF EXISTS trip_collection;
drop table IF EXISTS trip_like;
drop table IF EXISTS track_users;
drop table IF EXISTS itinerary_area;
drop table IF EXISTS itinerary_activity_type;
drop table IF EXISTS itinerary_activity_type_relationship;
drop table IF EXISTS trip_comment;
drop table IF EXISTS trip_location_relation;
drop table IF EXISTS trip_photo;
drop table IF EXISTS traffic_type;

-- 平台方 --
CREATE TABLE administrator (
administrator_id  			INT(11) NOT NULL AUTO_INCREMENT,
email						VARCHAR(50) NOT NULL ,
admin_account				VARCHAR(20) NOT NULL,
admin_password				VARCHAR(15) NOT NULL,
admin_name					VARCHAR(15) NOT NULL,
phone						VARCHAR(15) NOT NULL,
account_status				INT(1) 	NOT NULL,
create_time					timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
nick_name					VARCHAR(15) NOT NULL,
CONSTRAINT admin_id_pk PRIMARY KEY (administrator_id));

 INSERT INTO administrator(email, admin_account, admin_password ,admin_name, phone	,account_status,nick_name) VALUES ('seal@abc.com', 'seal123','seal456','seal','0952123456','1','seal');
 INSERT INTO administrator(email, admin_account, admin_password ,admin_name, phone	,account_status,nick_name) VALUES ('yuki@abc.com', 'yuki123','yuki456','yuki','0952123457','1','yuki');
 INSERT INTO administrator(email, admin_account, admin_password ,admin_name, phone	,account_status,nick_name) VALUES ('et@abc.com', 'et123','et456','et','0952123458','1','eatting');
 
 
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
CONSTRAINT pk_member_id PRIMARY KEY (member_id),
CONSTRAINT uk_email UNIQUE (email),
CONSTRAINT uk_account UNIQUE (account),
CONSTRAINT uk_phone UNIQUE (phone)
)COMMENT ' 一般用戶表';

 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('seal@abc.com', 'seal123','seal456','seal','0952123456','0','2024-12-01 08:00:00','seal','1');
 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('yuki@abc.com', 'yuki123','yuki456','yuki','0952123457','0','2024-12-01 09:00:00','yuki','1');
 INSERT INTO member(email,account,password,name,phone,status,create_time,nick_name,gender) VALUES ('et@abc.com', 'et123','et456','et','0952123458','0','2024-12-01 10:00:00','eatting','0');


-- 行程 --
create table trip (
trip_id					int(11) not null auto_increment comment'行程ID',
member_id				int(11) not null comment'會員ID',
abstract				text not null comment'行程概述',
create_time				timestamp default current_timestamp not null comment'文章建立時間',
collections				int(8) comment'收藏數',
status				    int(1) not null comment'文章狀態',
overall_score			int(10) not null comment'總評分',
overall_scored_people 	int(10) comment'總評分人數',
location_number 		int(10) comment'景點數',
article_title 			varchar(30) not null comment'文章標題',
visitors_number			int(10) comment'瀏覽人數',
likes					int(10) comment'點讚數',
constraint fk_member_member_id
foreign key (member_id) references member(member_id),
constraint trip_id_pk primary key(trip_id)
)comment'行程表';

insert into trip (member_id,status,abstract,create_time,overall_score,article_title) values ('1','1','東京三日遊，第一天...第二天...第三天','2024-12-01','4.5','東京三日遊的第一天');
insert into trip (member_id,status,abstract,create_time,overall_score,article_title) values ('1','1','東京三日遊，第一天...第二天...第三天','2024-12-01','4.5','東京三日遊的第二天');
insert into trip (member_id,status,abstract,create_time,overall_score,article_title) values ('1','1','東京三日遊，第一天...第二天...第三天','2024-12-01','4.5','東京三日遊的第三天');


-- 子行程 --
create table sub_trip(
sub_trip_id						int(11) not null comment'子行程ID',
trip_id							int(11) not null comment'行程ID',
`index`							int(2) not null comment'在行程中的順序',
content							longtext not null comment'文章內容',
constraint fk_sub_trip_trip_trip_id
foreign key(trip_id) references trip(trip_id),
constraint sub_trip_id primary key(sub_trip_id)
)comment'子行程表';

insert into sub_trip (trip_id,`index`,content) values ('1','1','東京三日遊，第一天去了大巨蛋、東京塔、澀谷'); -- 我是第一天 --
insert into sub_trip (trip_id,`index`,content) values ('1','2','東京三日遊，第二天去了迪士尼、淺草寺、原宿'); -- 我是第二天 --
insert into sub_trip (trip_id,`index`,content) values ('1','3','東京三日遊，第三天去了美術館、博物館、台場'); -- 我是第三天 --

-- 景點 --
create table location(
location_id				int(11) not null auto_increment comment'景點ID',
address					text not null comment'地址',
create_time				timestamp default current_timestamp not null comment'建立時間',
comments_number			int(8) comment'評論數',
score					float(2) not null comment'評分',
location_name			varchar(20) not null comment'地點名稱',
constraint pk_location_location_id primary key(location_id))comment'景點表';

insert into location (address,create_time,comments_number,score,location_name) values ('日本東京都文京區後樂','2024-12-12 20:00','3','5.0','東京巨蛋'); -- 我是第一天的巨蛋 --
insert into location (address,create_time,comments_number,score,location_name) values ('東京都港區芝公園4丁目','2024-12-12 20:00','3','5.0','東京鐵塔'); -- 我是第一天的鐵塔 --
insert into location (address,create_time,comments_number,score,location_name) values ('澀谷區宇田川町1番1號','2024-12-12 20:00','3','5.0','東京澀谷'); -- 我是第一天的澀谷 --

-- 公告 FK 平台方 --
 
 CREATE TABLE announcement (
announcement_id         INT(11) NOT NULL AUTO_INCREMENT,
admin_id				INT NOT NULL ,
title					text not null,
content          		 TEXT NOT NULL ,
create_time			timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
start_time			DATE NOT NULL ,
end_time           DATE NOT NULL ,
cover_photo		LONGBLOB,
constraint fk_announcement_administrator_id
foreign key (admin_id) references administrator (administrator_id),
CONSTRAINT announcement_id_pk PRIMARY KEY (announcement_id));

 insert into announcement(admin_id,title,content,start_time,end_time,cover_photo) values('1','冬季旅遊推薦','不要出門','2024-12-01','2024-12-31',null);
 insert into announcement(admin_id,title,content,start_time,end_time,cover_photo) values('2','聖誕旅遊推薦','不要去耶誕城','2024-12-10','2024-12-26',null);
 insert into announcement(admin_id,title,content,start_time,end_time,cover_photo) values('3','過年旅遊推薦','不要去親戚家','2025-2-01','2024-2-15',null);

-- 景點留言 FK 會員  景點 --

Create table  location_comment(
location_comment_id 	INT(11) NOT NULL AUTO_INCREMENT,
member_id				INT(11) NOT NULL ,
location_id        		INT(11) NOT NULL ,
content           		TEXT NOT NULL ,
photo					LONGBLOB,
score 					INT(1) NOT NULL,
create_time				timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
constraint fk_location_comment_member_member_id
foreign key (member_id) references member (member_id),
constraint fk__location_comment_location_location_id
foreign key (location_id) references location (location_id),
CONSTRAINT location_comment_id_pk PRIMARY KEY (location_comment_id));

insert into location_comment(member_id,location_id,content,photo,score) values('1','1','超讚不能只有我來過',null,'1');
insert into location_comment(member_id,location_id,content,photo,score) values('1','2','超讚不能只有我來過',null,'1');
insert into location_comment(member_id,location_id,content,photo,score) values('1','3','超讚不能只有我來過',null,'1');


-- 收藏行程  FK 行程 會員--
create table trip_collection(
trip_collection_id    	INT(11) NOT NULL AUTO_INCREMENT,
trip_id					INT(11) NOT NULL,
member_id				INT(11) NOT NULL,
create_time				timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
constraint fk_trip_collection_member_member_id
foreign key (member_id) references member (member_id),
constraint fk_trip_collection_trip_trip_id
foreign key (trip_id) references trip (trip_id),
constraint trip_collection_id_pk primary key (trip_collection_id));

-- 按讚行程  FK 行程 會員--
create table trip_like(
trip_like_id    		INT(11) NOT NULL AUTO_INCREMENT,
trip_id					INT(11) NOT NULL,
member_id				INT(11) NOT NULL,
create_time				timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
constraint fk_trip_like_member_member_id
foreign key (member_id) references member (member_id),
constraint fk_trip_like_trip_trip_id
foreign key (trip_id) references trip (trip_id),
constraint trip_like_id_pk primary key (trip_like_id));

-- 追蹤用戶  FK 會員 --
create table track_users(
track_users_id			INT(11) NOT NULL AUTO_INCREMENT,
track_member_id			INT(11) NOT NULL,
being_tracked_member_id	INT(11) NOT NULL,
track_time				timestamp DEFAULT CURRENT_TIMESTAMP  NOT NULL,
constraint fk_track_users_track_member_id_member_member_id
foreign key (track_member_id) references member (member_id),
constraint fk_track_users_being_tracked_member_id_member_member_id
foreign key (being_tracked_member_id) references member (member_id),			
constraint track_users_id_pk primary key (track_users_id));

 
-- 行程地區表 --
 CREATE TABLE itinerary_area (
trip_location_id         INT(11) NOT NULL AUTO_INCREMENT COMMENT '行程地區ID',
trip_id                  INT(11) NOT NULL COMMENT '行程ID',
region_content           TEXT  NOT NULL COMMENT'地區類型內容',
CONSTRAINT pk_trip_location_id PRIMARY KEY (trip_location_id),
CONSTRAINT fk_trip_id FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
)COMMENT '行程地區表';

 insert into itinerary_area(trip_id,region_content) values('1','東京');
 insert into itinerary_area(trip_id,region_content) values('2','台北');
 insert into itinerary_area(trip_id,region_content) values('3','桃園');

-- 行程活動類型表 --
 CREATE TABLE itinerary_activity_type (
event_type_id         INT(11) NOT NULL AUTO_INCREMENT COMMENT '活動類型ID',
event_content         TEXT  NOT NULL COMMENT '活動類型內容',
CONSTRAINT pk_event_type_id PRIMARY KEY (event_type_id)
)COMMENT '行程活動類型表';

 insert into itinerary_activity_type(event_content) values('觀光活動');
 insert into itinerary_activity_type(event_content) values('藝文活動');
 insert into itinerary_activity_type(event_content) values('空中活動');
 insert into itinerary_activity_type(event_content) values('海上活動');
 insert into itinerary_activity_type(event_content) values('體驗活動');
 insert into itinerary_activity_type(event_content) values('樂園活動');
 

-- 行程活動類型關係表 --
CREATE TABLE itinerary_activity_type_relationship (
    itinerary_activity_relationship_id INT(11) NOT NULL AUTO_INCREMENT COMMENT '行程活動類型關係ID',
    trip_id INT(11) NOT NULL COMMENT '行程ID',
    event_type_id INT(11) NOT NULL COMMENT '活動類型ID',
    CONSTRAINT pk_itinerary_activity_relationship_id PRIMARY KEY (itinerary_activity_relationship_id),
    CONSTRAINT fk_itinerary_activity_type_relationship_trip_id FOREIGN KEY (trip_id) REFERENCES trip(trip_id),
    CONSTRAINT fk_itinerary_activity_type_relationship_event_type_id FOREIGN KEY (event_type_id) REFERENCES itinerary_activity_type(event_type_id)
) COMMENT '行程活動類型關係表';


-- 行程留言表 --
CREATE TABLE trip_comment (
    trip_comment_id INT(11) NOT NULL AUTO_INCREMENT COMMENT '行程留言ID',
    member_id INT(11) NOT NULL COMMENT '會員ID',
    trip_id INT(11) NOT NULL COMMENT '行程ID',
    score INT(1) NOT NULL COMMENT '評分',
    photo LONGBLOB COMMENT '照片',
    create_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '建立時間',
    content LONGTEXT NOT NULL COMMENT '留言內容',
    CONSTRAINT pk_trip_comment_id PRIMARY KEY (trip_comment_id),
    CONSTRAINT fk_trip_comment_member_id FOREIGN KEY (member_id) REFERENCES member(member_id),
    CONSTRAINT fk_trip_comment_trip_id FOREIGN KEY (trip_id) REFERENCES trip(trip_id)
) COMMENT '行程留言表';


insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('1','1','5',null,'2024-12-01 15:30:45','這個行程太讚了吧!好想馬上照著行程去玩~');
insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('2','1','4',null,'2024-12-01 12:30:45','我也想要照這個行程安排旅行');
insert into trip_comment(member_id,trip_id,score,photo,create_time,content) values('3','1','4',null,'2024-12-01 13:30:45','好想馬上出發去旅遊哦~');


-- 行程景點關係 --
create table trip_location_relation(
trip_location_relation_id				int(11) not null auto_increment comment'行程景點關係ID',
sub_trip_id 					int(11) not null comment'子行程ID',
location_id						int(11) not null comment'景點ID',
`index`							int(2) not null comment'在子行程中的順序',
time_start						timestamp not null comment '景點開始時間',
time_end						timestamp not null comment'景點結束時間',
constraint fk_trip_location_relation_sub_trip_sub_trip_id
foreign key(sub_trip_id) references sub_trip(sub_trip_id),
constraint fk_trip_location_relation_location_location_id
foreign key(location_id)references location(location_id),
constraint trip_location_relation_id_pk primary key(trip_location_relation_id))comment '行程景點關係表';

insert into trip_location_relation(sub_trip_id,location_id,`index`,time_start,time_end)values('1','1','1','2024-12-12 8:00','2024-12-12 9:00'); -- 我是行程1拿出來的大巨蛋 --
insert into trip_location_relation(sub_trip_id,location_id,`index`,time_start,time_end)values('1','2','3','2024-12-12 10:00','2024-12-12 11:00'); -- 我是行程1拿出來的東京塔 --
insert into trip_location_relation(sub_trip_id,location_id,`index`,time_start,time_end)values('1','3','5','2024-12-12 12:00','2024-12-12 13:00'); -- 我是行程1拿出來的澀谷 --

-- 行程照片 --
create table trip_photo(
trip_photo_id				int(11) not null auto_increment,
trip_id						int(11) not null,
photo						longblob,
photo_type					int(1),				-- 0封面照片，1內文照片 --
constraint fk_trip_photo_trip_trip_id
foreign key(trip_id) references trip(trip_id),
constraint trip_photo_id primary key(trip_photo_id));


-- 交通方式 --
create table traffic_type(
traffic_type_id		int(11) not null auto_increment comment'交通方式ID',
type				int(1) not null comment'類型', -- 0未選擇,1開車,2火車,3捷運,4公車,5高鐵,6走路,7飛機 --
time_spent			int(11) comment'花費時間',
`index`				int(2) comment'在子行程中的順序',
trip_location_relation_id	int(11) not null comment'景點行程關係',
constraint pk_traffic_type_id primary key (traffic_type_id),
constraint fk_traffic_type_trip_location_relation_id foreign key (trip_location_relation_id) references trip_location_relation(trip_location_relation_id)
)comment '交通方式表';

insert into traffic_type (`type`,time_spent,`index`,trip_location_relation_id) values ('1','45','1','1');
insert into traffic_type (`type`,time_spent,`index`,trip_location_relation_id) values ('1','50','6','1');
