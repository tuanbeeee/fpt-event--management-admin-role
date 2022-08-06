
CREATE TABLE tblRoles (
    roleID varchar(10) primary key,
	roleName varchar(15) NOT NULL
);


CREATE TABLE tblUserTypes(
	typeID varchar(10) primary key,
	typeName varchar(50) not null
);


CREATE TABLE tblStatusType (
	statusTypeID varchar(20) primary key,
	statusTypeName varchar(50)
);

CREATE TABLE tblUsers (
    userID varchar(50) primary key,
	fullName varchar(50) not null,
	password varchar(50) not null,
	email varchar(50),
	status boolean not null,
	typeID varchar(10) references tblUserTypes (typeID),
	roleID varchar(10) references tblRoles (roleID),
	gender varchar(10),
	phone varchar(10),
	avatarUrl varchar
);

CREATE TABLE tblOrgPage (
    orgID varchar(20) primary key,
	status boolean,
	orgName varchar(50) not null,
	createDate date,
	description text,
	imgUrl varchar,
	email varchar(100),
	statusTypeID varchar(20) references tblStatusType(statusTypeID)
);


CREATE TABLE tblOrg_Follower 
(	
	userID varchar(50) references tblUsers (userID),
	orgID varchar(20) references tblOrgPage (orgID),
	status boolean,
	orgFollowerID int GENERATED ALWAYS AS IDENTITY primary key
);


CREATE TABLE tblBlog (
    blogID varchar(20) primary key,
	orgID varchar(20) references tblOrgPage(orgID),
	status boolean,
	title varchar not null,
	createDate date,
	content text,
	imgUrl varchar,
	numberOfView int,
	summary varchar
);


CREATE TABLE tblEventType (
	eventTypeID int GENERATED ALWAYS AS IDENTITY primary key,
	eventTypeName varchar(50) not null,
	status boolean
);

CREATE TABLE tblLocation (
	locationID int GENERATED ALWAYS AS IDENTITY primary key,
	locationName varchar(200) not null,
	status boolean
);

CREATE TABLE tblEventPost (
    eventID varchar(20) primary key,
	orgID varchar(20) references tblOrgPage(orgID),
	status boolean,
	statusTypeID varchar(20) references tblStatusType(statusTypeID),
	createDate date,
	takePlaceDate date,
	content text,
	title text,
	location int references tblLocation(locationID),
	imgUrl varchar,
	eventTypeID int references tblEventType(eventTypeID),
	numberOfView int,
	speaker varchar(100),
	approvalDes varchar,
	summary varchar not null
);

CREATE TABLE tblUserNotification
(
	userNoti int GENERATED ALWAYS AS IDENTITY primary key,
	userID varchar(50) references tblUsers (userID),
	eventID varchar(20) references tblEventPost (eventID),
	notiDate date not null,
	content varchar(200) not null
);


CREATE TABLE tblUser_Feedback
(
	userFeedback int primary key GENERATED ALWAYS AS IDENTITY,
	userID varchar(50) references tblUsers (userID),
	eventID varchar(20) references tblEventPost (eventID),
	content text
);

CREATE TABLE tblManagers (
	managerID varchar(50) references tblUsers (userID),
	orgID varchar(20) references tblOrgPage (orgID),
	primary key (managerID)
);


CREATE TABLE tblCommentSections(
	commentID int GENERATED ALWAYS AS IDENTITY,
	replyID int references tblCommentSections(commentID),
	status boolean,
	time timestamp not null,
	content text,
	userID varchar(50) references tblUsers (userID),
	eventID varchar(20) references tblEventPost (eventID),
	primary key (commentID)
);


CREATE TABLE tblParticipants(
	userID varchar(50) references tblUsers (userID),
	eventID varchar(20) references tblEventPost (eventID),
	status boolean,
	primary key (userID, eventID)
);


insert into tblRoles (roleID, roleName) values ('US', 'User');
insert into tblRoles (roleID, roleName) values ('MOD', 'FPTU Staff');
insert into tblRoles (roleID, roleName) values ('CLB', 'Club Member');
insert into tblRoles (roleID, roleName) values ('ADM', 'Admin');

insert into tblUserTypes (typeID, typeName) values ('LEC', 'Lecturer');
insert into tblUserTypes (typeID, typeName) values ('STU', 'Student');
insert into tblUserTypes (typeID, typeName) values ('EMP', 'Employee');

insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('Haisan', N'Hoàng Mạnh Hải', '1', 'fbenson0@51.la', '1', 'STU', 'US', 'Male', '0123456789', 'https://bloganh.net/wp-content/uploads/2021/03/chup-anh-dep-anh-sang-min.jpg');
insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('Honghx', N'Hoàng Xuân Hồng', '1', 'fbenson0@51.la', '1', 'LEC', 'US', 'Male', '0123456789', 'http://static1.bestie.vn/Mlog/ImageContent/202106/202106080209252204-6ec88eae-5394-45e6-85e0-640b4c8de751.jpeg');
insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('FPTU', 'Shayla', '1', 'rnijssen1@census.gov', '1', 'EMP', 'MOD', 'Male', '0123456789', 'https://static1.bestie.vn/Mlog/ImageContent/202106/15-cach-chup-anh-dep-van-nguoi-me-2021-c6778a.jpg');
insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('Lamsan', N'Lý Quốc Lâm', '1', 'rmaken2@ocn.ne.jp', '1', 'STU', 'CLB', 'Male', '0123456789', 'https://dulichvietnam.com.vn/vnt_upload/news/06_2021/ha_vi_chup_anh_nghe_thuat.jpg');
insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('Admin', N'Admin', '1', 'rmaken2@ocn.ne.jp', '1', 'EMP', 'ADM', 'Male', '0123456789', 'https://dulichvietnam.com.vn/vnt_upload/news/06_2021/ha_vi_chup_anh_nghe_thuat.jpg');
insert into tblUsers (userID, fullName, password, email, status, typeID, roleID, gender, phone, avatarUrl) values ('Thaisan', N'Minh Thái', '1', 'rmaken2@ocn.ne.jp', '1', 'STU', 'CLB', 'Male', '0123456789', 'https://dulichvietnam.com.vn/vnt_upload/news/06_2021/ha_vi_chup_anh_nghe_thuat.jpg');


insert into tblStatusType (statusTypeID,statusTypeName) values ('DE', 'Declined');
insert into tblStatusType (statusTypeID,statusTypeName) values ('AP', 'Approved');
insert into tblStatusType (statusTypeID,statusTypeName) values ('PE', 'Pending');

insert into tblOrgPage (orgID, status, orgName, createDate, description, imgUrl, email, statusTypeID) values ('FPT', '1', N'Đại Học FPT', '3/18/2022', N'Trường ĐH Hàng Đầu VN', 'https://scontent.fsgn2-5.fna.fbcdn.net/v/t39.30808-6/269967175_4864576610247728_3142802033791677496_n.jpg?_nc_cat=1&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=UiliUz9tD00AX_i3OGA&tn=sHGCvQeB3A7q8RuV&_nc_ht=scontent.fsgn2-5.fna&oh=00_AT-8ZpkzUa5kF7KcjAyzBq1nZTEZdCICs-I8JZXm2_CAEQ&oe=629351EA', 'daihocfpt@gmail.com','AP');
insert into tblOrgPage (orgID, status, orgName, createDate, description, imgUrl, email, statusTypeID) values ('CSG', '1', N'Cóc Sài Gòn', '4/3/2022', N'CLB Truyền Thông', 'https://scontent.fsgn2-4.fna.fbcdn.net/v/t39.30808-6/279648423_2161848750638220_1998983852737770039_n.jpg?_nc_cat=101&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=xeVHzf_1X2AAX8BgZOg&_nc_ht=scontent.fsgn2-4.fna&oh=00_AT_4EVn0e2RhcZQNPGxhS7-z8Gmgm_ds8GxNm0ZQ9Lg4tg&oe=62937A06' ,'cocsaigon@gmail.com','AP');
insert into tblOrgPage (orgID, status, orgName, createDate, description, imgUrl, email, statusTypeID) values ('FEV', '1', N'Câu lạc bộ FEV', '11/20/2021', N'Câu Lạc Bộ Sự Kiện', 'https://scontent.fsgn2-6.fna.fbcdn.net/v/t39.30808-6/280467990_2246999662123458_8740356583060559174_n.jpg?_nc_cat=111&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=kDABCjqoZ18AX_7AWuR&tn=sHGCvQeB3A7q8RuV&_nc_ht=scontent.fsgn2-6.fna&oh=00_AT-eIc57DkLYW_Pvq1bAamPRWUenX4gOok_Lvq7qsEfXWg&oe=6293DB32', 'fev@gmail.com','PE');
insert into tblOrgPage (orgID, status, orgName, createDate, description, imgUrl, email, statusTypeID) values ('SCT', '1', N'Skillcetera', '11/20/2021', N'Câu Lạc Bộ Kỹ Năng', 'https://scontent.fsgn2-3.fna.fbcdn.net/v/t39.30808-6/283267732_1695083524170254_1440168611628843337_n.jpg?_nc_cat=108&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=QvRTIb0UbFkAX9FU_Sq&_nc_ht=scontent.fsgn2-3.fna&oh=00_AT8yY5gHkYZNTh04U6cSPG2uZ6LXtAdkVPkkSeukxt7Byw&oe=62938D5A', 'skillcetera@gmail.com','AP');

insert into tblOrg_Follower (orgID, userID, status) values ('FPT', 'Haisan', '1');
insert into tblOrg_Follower (orgID, userID, status) values ('CSG', 'Haisan', '1');
insert into tblOrg_Follower (orgID, userID, status) values ('FEV', 'Haisan', '1');
insert into tblOrg_Follower (orgID, userID, status) values ('SCT', 'Honghx', '1');

insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG1', 'FPT', '1', 'Tadeas', '12/23/2021', 'Henrieta', 'https://vn4u.vn/wp-content/uploads/2018/05/tong-hop-nhung-mau-giao-dien-blog-ca-nhan-dep-chuan-xu-huong-20182.png', '5', 'Blog gì đó 0');
insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG2', 'CSG', '1', 'Lauren', '7/9/2021', 'Francoise', 'https://vn4u.vn/wp-content/uploads/2018/05/tong-hop-nhung-mau-giao-dien-blog-ca-nhan-dep-chuan-xu-huong-20182.png', '6', 'Blog gì đó 1');
insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG3', 'FEV', '1', 'Holly', '7/28/2021', 'Gay', 'https://vn4u.vn/wp-content/uploads/2018/05/tong-hop-nhung-mau-giao-dien-blog-ca-nhan-dep-chuan-xu-huong-20182.png', '7', 'Blog gì đó 2');
insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG4', 'SCT', '1', 'Audy', '9/7/2021', 'Lettie', 'https://vn4u.vn/wp-content/uploads/2018/05/tong-hop-nhung-mau-giao-dien-blog-ca-nhan-dep-chuan-xu-huong-20182.png', '8', 'Blog gì đó 3');
insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG5', 'FPT', '1', 'Vilhelmina', '1/7/2022', 'Renaud', 'https://vn4u.vn/wp-content/uploads/2018/05/tong-hop-nhung-mau-giao-dien-blog-ca-nhan-dep-chuan-xu-huong-20182.png', '9', 'Blog gì đó 4');
insert into tblBlog (blogID, orgID, status, title, createDate, content, imgUrl, numberOfView, summary) values ('BLG6', 'SCT', '1', 'REVIEW NHẸ CÁC NGÔN NGỮ, CÔNG NGHỆ, FRAMEWORK MÀ MÌNH ĐÃ VÀ ĐANG DÙNG KIẾM CƠM – PHẦN CUỐI', '1/7/2022', 'Hồi đó mình cũng thấy ghét, lại nghe nói code Angular rườm rà, build nặng nên cũng không thèm học.

Thế nhưng công ty dùng thì phải dùng thôi. Thế là mình lại phải lục tục lên Pluralsight tìm học Angular 2. May thay, dùng 1 thời gian mình cảm thấy Angular cũng … khá ổn, không tới nỗi tệ như mình nghĩ:

Cấu trúc code khá tường minh, chia làm module, service, 1 component tách riêng logic, template, style ra file riêng
Framework hỗ trợ tận răng từ routing, validation, format tới API call, không cần xài thêm thư viện ngoài
Một component có Input/Output, cũng na ná props và callback bên trong React
Dùng TypeScript nên tooling ngon, refactor dễ, đọc là biết input/output/typing của các hàm ra sao
Có gắn kèm RxJS, làm được nhiều trò hay ho bá đạo
', 'https://toidicodedao.files.wordpress.com/2021/02/build-apis-in-nodejs-and-swagger-20-with-apigee127-8-638-e1612952063895.jpg', '9', N'Hiện tại, mình đang làm tại SwatMobility. Team dev cũng nho nhỏ (tổng cộng tầm 8-10 người), nhưng anh em làm việc rất vui và chuyên nghiệp!

Kì này, mình sẽ đánh giá những công nghệ mà mình và team đang dùng, điểm mạnh/điểm yếu và những điều mình thích/ghét về chúng nhé.');


insert into tblEventType(eventTypeName, status) values ('WorkShop' , '1');
insert into tblEventType(eventTypeName, status) values (N'Triển Lãm' , '1');
insert into tblEventType(eventTypeName, status) values ('Seminar' , '1');

insert into tblLocation(locationName, status) values (N'Hội Trường A, Đại Học FPT' , '1');
insert into tblLocation(locationName, status) values (N'Hội Trường B, Đại Học FPT' , '1');
insert into tblLocation(locationName, status) values (N'Sân trường Đại Học FPT' , '1');
insert into tblLocation(locationName, status) values (N'Sảnh Trống Đồng Đại Học FPT', '1');


insert into tblEventPost (eventID, orgID, status, statusTypeID, createDate, takePlaceDate, content, title, location, imgUrl, eventTypeID, numberOfView, speaker, summary, approvalDes) values ('EVT1', 'FPT', '1', 'AP', '6/17/2021', '3/12/2022', N'Sự kiện đàn hát gì đó', N'Khởi động cuộc thi nhạc cụ dân tộc FPT Edu Tích Tịch Tình Tang', 1, 'https://daihoc.fpt.edu.vn/wp-content/uploads/2022/05/cuoc-thi-nhac-cu-dan-toc-1653533015-1-373x206.jpg', 2, '3', N'Thầy Lâm', N'Thổi sáo các kiểu','');
insert into tblEventPost (eventID, orgID, status, statusTypeID, createDate, takePlaceDate, content, title, location, imgUrl, eventTypeID, numberOfView, speaker, summary, approvalDes) values ('EVT2', 'CSG', '1', 'PE', '2/5/2022', '11/15/2021', N'Sự kiện chụp hình gì đó', N'Gặp gỡ nhiếp ảnh gia Hậu Lê tại talkshow “Nhiếp ảnh thời trang hiện đại”', 2, 'https://daihoc.fpt.edu.vn/wp-content/uploads/2022/05/dai-hoc-fpt-tphcm-1653126990-373x206.jpeg', 3, '3', N'Cô A', N'Thời trang cách thứ','');
insert into tblEventPost (eventID, orgID, status, statusTypeID, createDate, takePlaceDate, content, title, location, imgUrl, eventTypeID, numberOfView, speaker, summary, approvalDes) values ('EVT3', 'CSG', '1', 'PE', '4/15/2022', '11/19/2021', N'Binz tham gia music tour toàn quốc cùng Đại học FPT', N'Binz đi tour toàn quốc nhưng ko về HCM', 3, 'https://daihoc.fpt.edu.vn/wp-content/uploads/2022/05/binz-bieu-dien-tai-dai-hoc-fpt-2-1652335881-373x206.jpeg', 1, '3', N'Binz', N'Binz rap các thứ','');
insert into tblEventPost (eventID, orgID, status, statusTypeID, createDate, takePlaceDate, content, title, location, imgUrl, eventTypeID, numberOfView, speaker, summary, approvalDes) values ('EVT4', 'SCT', '1', 'DE', '4/15/2022', '11/19/2021', N'Hôm nay Bích Phương buồn', N'nhận một cú lừa nhưng bích phương không quá buồn như anh nghĩ đâu', 4, 'https://static2.yan.vn/YanThumbNews/2167221/202005/720x400_ba07596d-e465-419d-8c09-9cd53694c8d4.jpg', 2, '3', N'Bích Phương', N'Bích Phương hát hò các thứ','');
insert into tblEventPost (eventID, orgID, status, statusTypeID, createDate, takePlaceDate, content, title, location, imgUrl, eventTypeID, numberOfView, speaker, summary, approvalDes) values ('EVT5', 'SCT', '1', 'AP', '4/15/2022', '06/19/2022', N'Nguyễn Lâm Thảo Tâm - cô gái được công chúng biết đến nhiều qua vai diễn cô giáo Hồng có vẻ ngoài xinh xắn, phong cách nhu mì trong bộ phim đình đám Mắt Biếc. Tuy nhiên, trước khi đến với vai diễn này, Thảo Tâm đã là một gương mặt quen thuộc trong các chương trình tiếng Anh của VTV với các thành tích học tập đáng ngưỡng mộ.
Vào năm 2015, Thảo Tâm xuất sắc giành được giải thưởng cao nhất cho cuộc thi Học sinh giỏi quốc gia môn tiếng Anh (Gold Medal of National English Olympiad 2015). Tiếp đó, cô còn trở thành quán quân EF Challenge Vietnam năm 2016 và đại diện cho thanh niên Việt Nam tham dự Diễn đàn lãnh đạo trẻ thế giới 2016 tại Brazil. Đến năm 2017, Thảo Tâm tiếp tục giành được huy chương vàng cuộc thi Học sinh giỏi 30/4 môn tiếng Anh (Gold Medal of 30/04 English Olympiad 2017). 
Song song với việc học tập, Thảo Tâm còn lấn sân qua lĩnh vực phim ảnh, người mẫu và MC. Với khả năng tiếng Anh nổi bật của mình, cô đã trở thành một trong những gương mặt thân quen trong chương trình IELTS Face-off nhiều mùa. Gần đây nhất, Thảo Tâm có mặt trong danh sách đề cử Nữ diễn viên phụ xuất sắc nhất Ngôi sao xanh 2020 với vai diễn Cô giáo Hồng trong bộ phim Mắt Biếc.
Một cô gái tuổi đôi mươi nhưng đã đạt được nhiều thành tích đáng nể thì chắc chắn sẽ có rất nhiều câu chuyện để chia sẻ. Vì vậy, chúng ta hãy cùng hẹn gặp Thảo Tâm trên sân khấu TEDxFPTUniversityHCMC 2021 nhé!!!', N'Cô gái Nguyễn Lâm Thảo Tâm và con đường phát triển bản thân', 1, 'https://img.theinfluencer.vn/thumb_w/850/uploads/2021/07/pKVP3EPsJCTf8nRtk1Fntddzufe3AWgcoSYw2AKF.png', 1, '3', N'Nguyễn Lâm Thảo Tâm', N'Nguyễn Lâm Thảo Tâm - một cô gái trẻ tài năng được biết đến với nhiều vai diễn xuất sắc và khả năng ngoại ngữ vượt trội.','');

insert into tblParticipants (userID, eventID, status) values ('Haisan', 'EVT1', '1');
insert into tblParticipants (userID, eventID, status) values ('Honghx', 'EVT1', '1');

insert into tblCommentSections (replyID, status, time, content, userID, eventID) values (null, '1', '2/27/2022', N'MTP Xấu Trai!!', 'Honghx', 'EVT1');
insert into tblCommentSections (replyID, status, time, content, userID, eventID) values (null, '1', '9/13/2021', 'Goldina', 'Lamsan', 'EVT1');
insert into tblCommentSections (replyID, status, time, content, userID, eventID) values ('1', '1', '4/13/2022', N'MTP Đẹp trai mà?', 'Haisan', 'EVT1');
insert into tblCommentSections (replyID, status, time, content, userID, eventID) values ('2', '1', '7/12/2021', 'Cobby', 'Honghx', 'EVT1');

insert into tblManagers (managerID, orgID) values ('Lamsan', 'CSG');
insert into tblManagers (managerID, orgID) values ('FPTU', 'FPT');
insert into tblManagers (managerID, orgID) values ('Thaisan', 'SCT');
insert into tblManagers (managerID, orgID) values ('Admin', 'FPT');

INSERT INTO tblUser_Feedback (userID, eventID, content) values ('Haisan', 'EVT1', N'Event này cần mời anh Bin yét');
INSERT INTO tblUser_Feedback (userID, eventID, content) values ('Honghx', 'EVT2', N'Event cháy qá!!');

INSERT INTO tblUserNotification (userID, eventID, notiDate, content) values ('FPTU', 'EVT2', '2021-12-12', 'CSG have a new post need to be approve. Check it out!');
INSERT INTO tblUserNotification (userID, eventID, notiDate, content) values ('Lamsan', 'EVT2', '2021-12-12', '#EVT2 has been APPROVED!!');
INSERT INTO tblUserNotification (userID, eventID, notiDate, content) values ('Haisan', 'EVT2', '2021-12-12', 'Cóc Sài Gòn has new Event! Check it out!');





CREATE OR REPLACE FUNCTION ufn_removeMark (x text) RETURNS text AS 
$$
DECLARE
   codau text; kdau text; r text;
BEGIN
   codau = 'áàảãạâấầẩẫậăắằẳẵặđéèẻẽẹêếềểễệíìỉĩịóòỏõọôốồổỗộơớờởỡợúùủũụưứừửữựýỳỷỹỵÁÀẢÃẠÂẤẦẨẪẬĂẮẰẲẴẶĐÉÈẺẼẸÊẾỀỂỄỆÍÌỈĨỊÓÒỎÕỌÔỐỒỔỖỘƠỚỜỞỠỢÚÙỦŨỤƯỨỪỬỮỰÝỲỶỸỴ';
   kdau  = 'aaaaaaaaaaaaaaaaadeeeeeeeeeeeiiiiiooooooooooooooooouuuuuuuuuuuyyyyyAAAAAAAAAAAAAAAAADEEEEEEEEEEEIIIIIOOOOOOOOOOOOOOOOOUUUUUUUUUUUYYYYY';
   r = x;
   FOR i IN 0..length(codau)
   LOOP
        r = replace(r, substr(codau,i,1), substr(kdau,i,1));
   END LOOP;
   RETURN LOWER(r);
END;
$$ LANGUAGE plpgsql;


--===========================================================================


