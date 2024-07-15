create database ShoeSense;

USE ShoeSense;

create table Account(
accountID int primary key IDENTITY(1,1) not null,
accountEmail nvarchar(50) not null,
accountPassword nvarchar(50) not null,
accountName nvarchar(100),
accountGender nvarchar(20) not null,
accountBirthdate date,
accountPhone nvarchar(10),
accountAddress nvarchar(500) not null,
accountRole nvarchar(5) not null,
accountStatus nvarchar(10) not null,
otp nvarchar(64),
otp_time datetime

);

--create table AccountAddress(
--addressID int primary key IDENTITY(1,1) not null,
--accountID int foreign key references Account(accountID) not null,
--addressName nvarchar(500) not null,
--addressDis nvarchar(500) not null
--);


create table Product(
productID int primary key IDENTITY(1,1) not null,
productName nvarchar(500) not null,
productPrice money,
productImg nvarchar(500),
productCategory nvarchar(500),
productDis nvarchar(500),
productStatus nvarchar(20)
);

--create table ProductImage(
--imgID int primary key IDENTITY(1,1) not null,
--productID int foreign key references Product(productID) not null,
--imgURL nvarchar(500),
--);

create table ProductVariant(
variantID int primary key IDENTITY(1,1) not null,
productID int foreign key references Product(productID) not null,
variantImg nvarchar(500),
variantSize nvarchar(3) not null,
variantColor nvarchar(20) not null,
variantQuantity int ,
);


create table Cart(
cartID int primary key IDENTITY(1,1) not null,
accountID int foreign key references Account(accountID) not null,
productID int foreign key references [Product](productID) not null,
variantID int foreign key references ProductVariant(variantID) not null,
quantity int

);

--create table CartDetail(
--cartID int primary key IDENTITY(1,1) not null,
--productID int foreign key references [Product](productID) not null,
--variantID int foreign key references ProductVariant(variantID) not null,
--quantity int
--);

create table Import(
importID int primary key IDENTITY(1,1) not null,
importDate datetime,
accountID int foreign key references Account(accountID) not null,
productID int foreign key references Product(productID) not null,
variantID int foreign key references ProductVariant(variantID) not null,
quantity int
);

--create table ImportDetail(
--	importID int foreign key references [Import](importID) not null,
--	productID int foreign key references Product(productID) not null,
--	variantID int foreign key references ProductVariant(variantID) not null,
--	quantity int
--);

create table [Order](
	orderID int primary key IDENTITY(1,1) not null,
	accountID int foreign key references Account(accountID) not null,
	orderAddress nvarchar(500) not null,
	paymentMethod nvarchar(100) not null,
	totalPrice money,
	orderStatus nvarchar(100)
);

CREATE TABLE OrderStatusLog (
    orderID INT FOREIGN KEY REFERENCES [Order](orderID) NOT NULL,
	accountID int foreign key references Account(accountID),
    statusDate DATETIME NOT NULL,
	orderStatus nvarchar(100)
);

create table [OrderDetail](
	orderID int foreign key references [Order](orderID) not null,
	productID int foreign key references Product(productID) not null,
	variantID int foreign key references ProductVariant(variantID) not null,
	quantity int,
	total money
);

CREATE TABLE [Comment](
	commentID int IDENTITY(1,1) NOT NULL,
	productID int foreign key references Product(productID) not null,
	accountID int foreign key references Account(accountID) not null,
	content nvarchar(max) NOT NULL,
	createdDate datetime NOT NULL,
	commentStatus nvarchar(20)
);



-- Insert values
INSERT INTO Account
VALUES 
--                       Password== 123456
	('user1@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'User', 'Male', '2003-12-19', '0312697274', 'An Giang', 'User', 'Active', null, null),
	('user2@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'User user', 'Male', '2003-12-19', '0312697274', 'An Giang', 'User', 'Active', null, null),
	('user3@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'User user user', 'Male', '2003-12-19', '0312697274', 'An Giang', 'User', 'Banned', null, null),
	('staff@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Staff staff', 'Female', '2003-12-19', '0312697274', 'Soc Trang',  'Staff', 'Active', null, null),
	('admin@gmail.com', 'e10adc3949ba59abbe56e057f20f883e', 'Admin admin', 'Other', '2003-12-19', '0312697274', 'An Giang', 'Admin', 'Active', null, null);



INSERT INTO Product
VALUES 
	('Shoe1', '100000.00', './img/product/OIP (1).jpg', 'Shoe', 'Shoe dis', 'Public'),
		('Sandal1', '100000.00', './img/product/OIP.jpg', 'Sandal', 'Sandal dis', 'Public'),
			('Boot1', '100000.00', './img/product/ath-293124626.png', 'Boot', 'Boot dis', 'Hide'),
			('Heel1', '100000.00', './img/product/ath-293124626.png', 'Heel', 'Boot dis', 'Hide'),
			('Heel2', '100000.00', './img/product/ath-293124626.png', 'Heel', 'Boot dis', 'Hide');

	


INSERT INTO ProductVariant
VALUES 
	( 1, './img/product/OIP.jpg', '3', 'Red', '5'),
	( 1, './img/product/ath-293124626.png', '3', 'Green', '5');


INSERT INTO [Order]
VALUES 
	(1,  'VietNam', 'Cash', 100.00, 'Processing'),
		(1,  'VietNam', 'Cash', 100000.00, 'Delivered');
	



INSERT INTO OrderStatusLog
VALUES 
	(1, null,GETDATE(), 'Processing'),
	(2, null,GETDATE(), 'Processing'),
	(2, 5,GETDATE(), 'Delivered');




INSERT INTO [OrderDetail]
VALUES 
	(1,1, 1, 1, 1000.00);

	INSERT INTO Comment
VALUES 
	(1,1, 'Cool Product', GETDATE(), 'Public');