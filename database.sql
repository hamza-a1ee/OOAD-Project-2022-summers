create database dbMyOnlineShopping

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~CATEGORY TABLE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_Category
(
CategoryId int identity primary key,
CategoryName varchar(500) unique,
IsActive bit null,
IsDelete bit null
)
select*from Tbl_Category
insert into Tbl_Category values
('Desktop','true','False')
insert into Tbl_Category values
('Laptops','true','False')
insert into Tbl_Category values
('Camera','true','False')
insert into Tbl_Category values
('HomeAppliances','true','False')
insert into Tbl_Category values
('AppleStore','true','False')
insert into Tbl_Category values
('Mobile','true','False')
insert into Tbl_Category values
('Accessories','true','False')
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Product Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
create table Tbl_Product
(
ProductId int identity primary key,
ProductName varchar(500) unique,
CategoryId int,
IsActive bit null,
IsDelete bit null,
CreatedDate datetime null,
ModifiedDate datetime null,
ProductImage varchar(max),
IsFeatured bit null ,
Quantity int,
Price decimal(18,0)
foreign key (CategoryId) references Tbl_Category(CategoryId)
)
select*from Tbl_Product
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Member Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_Member
(
MemberId int identity primary key,
FirstName varchar(50),
LastName varchar(50) unique,
EmailId varchar(50) unique,
Password varchar(50),
IsActive bit null,
IsDelete bit null,
CreatedOn datetime,
ModifiedOn datetime,
Salary int
)

alter table Tbl_Member add  Salary int;
alter table Tbl_Member add  City varchar(50);
alter table Tbl_Member add  Gender varchar(50);
alter table Tbl_Member drop column CreatedOn;
alter table Tbl_Member drop column ModifiedOn;

select*from Tbl_Member
delete from Tbl_Member where MemberId=2
delete from Tbl_Member where MemberId=1 
insert into Tbl_Member values('Raza','Khan','razakhan@gmail.com','abc123','True','False',25000,'Karachi','Male')
insert into Tbl_Member values('Hira','Gul','hira@gmail.com','abc821','True','False',15000,'Karachi','Female')
insert into Tbl_Member values('Zaid','Ali','zaid@gmail.com','123','True','False',25000,'Lahore','Male')
insert into Tbl_Member values('Maryem','Jamal','meryem@gmail.com','821','True','False',16000,'Lahore','Female')
insert into Tbl_Member values('Muhammad ','Sarah','sarahkhan@gmail.com','cvb123','True','False',75000,'Islamabad','Female')
insert into Tbl_Member values('Meesha','Malik','meesha@gmail.com','821abc','True','False',85000,'Islamabad','Female')

delete from Tbl_Member where MemberId>2
select * from Tbl_Member where SUM(Salary)>4000



select MemberId,FirstName,LastName,EmailId,SUM(Salary) as [total Salary] from
Tbl_Member group by MemberId,FirstName,LastName,EmailId order by FirstName
select*from Tbl_Member

select FirstName,LastName,SUM(salary) as [total Salary] from 
Tbl_Member group by FirstName,LastName order by FirstName
select*from Tbl_Member

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slide Image Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

-----------------------------------------

select City,Gender,Max(Salary) as [Total Salary],
COUNT(MemberId) as [Total No. of Members] from Tbl_Member
group by City,Gender order by City
select*from Tbl_Member

---------------------------------------------------


select City,Gender,Sum(Salary) as [Total Salary],
COUNT(MemberId) as [Total No. of Members] from Tbl_Member
where Gender='Male' group by City,Gender order by City
select*from Tbl_Member




select City,Gender,min(Salary) as [Total Salary],
COUNT(MemberId) as [Total No. of Members] from Tbl_Member
group by City,Gender order by City
select*from Tbl_Member


select City,Gender,avg(Salary) as [Total Salary],
COUNT(MemberId) as [Total No. of Members] from Tbl_Member
group by City,Gender order by City
select*from Tbl_Member

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Wilde Cards~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
select*from Tbl_Member where EmailId like'z%'
select *from Tbl_Member where Salary between 16000 and 25000

select*from Tbl_Member


--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Slide Image Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_SlideImage
(
SlideId int identity primary key,
SlideTitle varchar(500),
SlideImage varchar(max)
)

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Shipping Details Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_ShippingDetail
(
ShippingDetailId int identity primary key ,
MemberId int,
Adress varchar(250),
City varchar(50),
State varchar(50),
Country varchar(50),
ZipCode int,
OrderId int,
AmountPaid decimal,
PaymentType varchar(50),
foreign key (MemberId) references Tbl_Member(MemberId)
)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Cart Status Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_CartStatus
(
CartStatusId int identity primary key,
CartStatus varchar(500)
)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Cart Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_Cart
(
CartId int identity primary key,
ProductId int,
MemberId int,
CartStatusId int,
foreign key (ProductId) references Tbl_Product(ProductId)
)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Member Role Table~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


create table Tbl_MemberRole
(
MemberRoleID int identity primary key,
memberId int,
RoleId int,
)
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Roles TABLE~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

create table Tbl_Roles
(
RoleId int identity primary key,
RoleName varchar(200) unique
)

---------------------------Cascade Referential-------------------------
/*
1. No Action
2. Default Constraint
3. Cascade
4. Set Null


*/
select*from Tbl_Product
select*from Tbl_Category

alter table Tbl_Product add constraint FK_Tbl_Product_CategoryId
foreign key (CategoryId) references Tbl_Category(CategoryId) on update set null

alter table Tbl_Product add constraint FK_customer_CategoryId
foreign key (CategoryId) references product(ProductId) on delete cascade


           
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Sub Query~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

select*from Tbl_Member
select FirstName,Salary from Tbl_Member
where Salary>
(select Salary from Tbl_Member where FirstName='Zaid')



--------------------------Stored Procedure Without Parameters--------------------
alter Proc SpGet_Tbl_Member_FirstName_And_EmailId
as
begin
Select FirstName,EmailId from Tbl_Member
end

Exec SpGet_Tbl_Member_FirstName_And_EmailId
-----------------------------------------------------------------------

-------------------------Stored Procedure With Input Parameters--------------------


alter Proc SpGet_Tbl_Member_By_ID
@id int
as
begin
select*from Tbl_Member where MemberId=@id 
end
Exec SpGet_Tbl_Member_By_ID 02
-----------------------------------------------------------------------

----------------------Stored Procedure With Output Parameters--------------------
create Proc spGetTbl_Member_CountBy_FirstName
@FirstName varchar(10),
@MemberCount int output
as
begin
select @MemberCount=Count(MemberId)from Tbl_Member where FirstName=@FirstName
end

declare @MemberTotal int
Execute spGetTbl_Member_CountBy_FirstName'Hira',@MemberTotal output
select @MemberTotal as Total_Members
-----------------------------------------------------------------------
---------------------Stored Procedure With Return Values---------------
create Proc spGetTbl_Product_CountBy

as
begin
return(select COUNT(ProductId)from Tbl_Product)
end

declare @ProductsTotal int
Execute @ProductsTotal =spGetTbl_Product_CountBy
select @ProductsTotal as [Total_Products]

-----------------------------------------------------------------------

--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Triggers~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(a)Inserted~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

CREATE table tbl_AUDIT
(
Aut_ID int primary key identity,
Aut_Info varchar(max)
)
select*from tbl_AUDIT
select*from Tbl_Member

insert into Tbl_Member values('Hurrain','Fatima','hurrain123@gmail.com','123','True','False',90000)

create trigger tr_tbl_AUDIT on Tbl_Member
after insert
as
begin
Declare @id int
select @id = MemberId from inserted
insert into tbl_AUDIT values('Member With ID '+Cast(@id as varchar(50))+'is added at'+Cast(Getdate() as varchar(50)))
end


--~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~(b)Deletion~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

alter trigger tr_tbl_AUDIT on Tbl_Member
after delete
as
begin
Declare @id int
select @id = MemberId from deleted
insert into tbl_AUDIT values('Member With ID '+Cast(@id as varchar(50))+'is Deleted at'+Cast(Getdate() as varchar(50)))
end

delete from Tbl_Member where Salary=90000

select*from Tbl_Product






