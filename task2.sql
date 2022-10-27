create database customer;
use customer;

create table salesman(
    salesman_id int,
	name varchar(20),
	city varchar(20),
	commission decimal(5,2)
);

select * from salesman;

insert into salesman
values ('5001','James Hoog','New York',0.15),
       ('5002','Nail Knite','Paris',0.13),
	   ('5005','Pit Alex', 'London', 0.11),
	   ('5006','Mc Lyon','Paris',0.14),
	   ('5007','Paul Adam','Rome',0.13),
	   ('5003','Lauson Hen','San Jose',0.12);

create table customer(
    customer_id int,
	cust_name varchar(20),
	city varchar(20),
	grade int,
	salesman_id int
);

select * from customer;

insert into customer
values ('3002','Nick Rimando','New York',100,'5001'),
       ('3007','Brad Davis','New York',200,'5001'),
	   ('3005','Graham Zusi','California',200,'5002'),
	   ('3008','Julian Green','London',300,'5002'),
	   ('3004','Fabian Johnson','Paris',300,'5006'),
	   ('3009','Geoff Cameron','Berlin',100,'5003');

select cus.cust_name, sal.name, sal.city as city from salesman sal, customer cus where sal.city= cus.city;

select cus.cust_name, sal.name from customer cus, salesman sal where cus.salesman_id=sal.salesman_id;

create table foods(
    ITEM_ID int,
	ITEM_NAME varchar(20),
	ITEM_UNIT varchar(10),
	COMPANY_ID int
);

select * from foods;

insert into foods
values (1,'Chex Mix','Pcs',16),
       (6,'Chezz-It','Pcs',15),
	   (2,'BN Biscuit','Pcs',15),
	   (3,'Mighty Munch','Pcs',17),
	   (4,'Pot Rice','Pcs',15),
	   (5,'Jaffa Cakes','Pcs',18),
	   (7,'Salt n Shake','Pcs',null);

create table company(
    COMPANY_ID int,
	COMPANY_NAME varchar(20),
	COMPANY_CITY varchar(20)
);

select * from company;

insert into company
values (18,'Order All','Boston'),
       (15,'Jack Hill Ltd','London'),
	   (16,'Akas Foods','Delhi'),
	   (17,'Foodies','London'),
	   (19,'sip-n-Bite','New York');

select * from company;
select * from foods;
select * from counter_sale;

select company.COMPANY_ID, company.COMPANY_NAME, foods.COMPANY_ID, foods.ITEM_NAME, foods.ITEM_UNIT from company left join foods on company.COMPANY_ID=foods.COMPANY_ID;

create table counter_sale(
    BILL_NO int,
	ITEM_ID int,
	SL_QTY int,
	SL_RATE int,
	BILL_AMT int
);

select * from counter_sale;
truncate table counter_sale;

insert into counter_sale
values (1003,6,15,20,300),
       (1004,4,18,30,540),
	   (1005,7,10,60,600),
	   (1006,3,25,25,625),
	   (1001,4,20,30,600),
	   (1002,1,40,50,2000);

select  bill.BILL_No, food.ITEM_NAME, bill.BILL_AMT from counter_sale bill, foods food where bill.BILL_AMT> 500 and bill.ITEM_ID=food.ITEM_ID;

select  bill.BILL_NO, food.ITEM_NAME, com.COMPANY_NAME, com.COMPANY_CITY, bill.BILL_AMT from counter_sale bill left join foods food on bill.ITEM_ID = food.ITEM_ID left join company com on food.COMPANY_ID=com.COMPANY_ID where com.COMPANY_NAME is not null order by bill.BILL_NO;

select com.COMPANY_ID, com.COMPANY_NAME, com.COMPANY_city, food.COMPANY_ID, food.ITEM_NAME from company com right join foods food on com.COMPANY_ID=food.COMPANY_ID;

select a.COMPANY_NAME, a.COMPANY_CITY, b.COMPANY_NAME from company a, company b where a.COMPANY_CITY=b.COMPANY_CITY;

create table agents(
    AGENT_CODE varchar(10),
	AGENT_NAME varchar(20),
	WORKING_AREA varchar(20),
	COMMISSION decimal(5, 2),
	PHONE_NO varchar(20),
	COUNTRY varchar(20)
);

select * from agents;

insert into agents
values ('A007','Ramasundar','Bangalore',0.15,'077-25814763',null),
       ('A003','Alex','London',0.13,'075-12458969',null),
	   ('A008','Alford','New York',0.12,'044-25874365',null),
	   ('A011','Ravi Kumar','Bangalore',0.15,'077-45625874',null),
	   ('A010','Santakumar','Chennai',0.14,'007-22388644',null),
	   ('A012','Lucida','San Jose',0.12,'044-52981425',null),
	   ('A005','Anderson','Brisban',0.13,'045-21447739',null),
	   ('A001','Subbarao','Bangalore',0.14,'077-12346674',null);

create table orders(
    ORD_NUM int,
	ORD_Amount int, 
	ADVANCE_AMOUNT int,
	ORD_DATE varchar(20),
	CUST_CODE varchar(10),
	AGENT_CODE varchar(10),
	ORD_DESCRIPTION varchar(50)
);

select * from orders;

select * from agents;

insert into orders
values (200114, 3500, 2000, '15-AUG-08', 'C00002','A008',null),
       (200122, 2500, 400, '16-SEP-08', 'C00003','A004',null),
	   (200118, 500, 100, '20-JUL-08', 'C00023','A006',null),
	   (200119, 4000, 700, '16-SEP-08', 'C00007','A010',null),
	   (200121, 1500, 600, '23-SEP-08', 'C00008','A004',null),
	   (200130, 2500, 400, '30-JUL-08', 'C00025','A011',null),
	   (200134, 4200, 1800, '25-SEP-08', 'C00004','A005',null),
	   (200108, 4000, 600, '15-FEB-08', 'C00008','A004',null),
	   (200103, 1500, 700, '15-MAY-08', 'C00021','A005',null);

select agnt.AGENT_CODE, agnt.AGENT_NAME, sum(ord.ADVANCE_AMOUNT) as "SUM(ORDERS.ADVANCE_AMOUNT)" from agents agnt, orders ord where agnt.AGENT_CODE=ord.AGENT_CODE group by agnt.AGENT_CODE, agnt.AGENT_NAME  order by agnt.AGENT_CODE;

alter table company alter column COMPANY_ID int not null ;

alter table company add primary key (COMPANY_ID);

alter table foods add foreign key(COMPANY_ID) references company(COMPANY_ID);

select food.ITEM_NAME, food.ITEM_UNIT, com.COMPANY_NAME, com.COMPANY_CITY from foods food, company com where food.COMPANY_ID=com.COMPANY_ID and com.COMPANY_CITY='London';

create table despatch(
    DES_NUM varchar(10),
	DES_DATE varchar(20),
	DES_AMOUNT int,
	ORD_NUM int,
	ORD_DATE varchar(20),
	ORD_AMOUNT int,
    AGENT_CODE varchar(10)
);

select * from despatch;

insert into despatch
values ('D002','10-JUN-08',2000,200112,'30-MAY-08',2000,'A007'),
       ('D005','19-OCT-08',4000,200119,'16-SEP-08',4000,'A010'),
	   ('D001','12-JAN-08',3800,200113,'10-JUN-08',4000,'A002'),
	   ('D003','25-OCT-08',900,200117,'20-OCT-08',800,'A001'),
	   ('D004','20-AUG-08',450,200120,'20-JUL-08',500,'A002'),
	   ('D006','24-JUL-08',4500,200128,'20-JUL-08',3500,'A002');

select a.DES_NUM, a.DES_DATE, sum(b.ORD_Amount) as "SUM(B.ORD_AMOUNT)" from despatch a, orders b where a.ORD_AMOUNT=b.ORD_Amount group by a.DES_NUM,a.DES_DATE;

select ORD_NUM, ORD_Amount, ORD_DATE, CUST_CODE, AGENT_CODE from orders where AGENT_CODE in (select AGENT_CODE from agents where WORKING_AREA='Bangalore'); 

create table customer2(
    CUST_CODE varchar(10),
	CUST_NAME varchar(20),
	CUST_CITY varchar(20),
	WORKING_AREA varchar(20),
	CUST_COUNTRY varchar(10),
	GRADE int,
	OPENING_AMT decimal(10,2),
	RECEIVE_AMT decimal(10,2)
);

select * from customer2;

insert into customer2
values ('C00013','Holmes','London','London','UK',2,6000.00,5000.00),
       ('C00001','Michael','New York','New York','USA',2,3000.00,5000.00),
	   ('C00020','Albert','New York','New York','USA',3,5000.00,7000.00),
	   ('C00025','Ravindran','Bangalore','Bangalore','India',2,5000.00,7000.00),
	   ('C00024','Cook','London','London','UK',2,4000.00,9000.00),
	   ('C00015','Stuart','London','London','UK',1,6000.00,8000.00),
	   ('C00002','Bolt','New York','New York','USA',3,5000.00,7000.00);

select CUST_COUNTRY, count(GRADE) as "COUNT(GRADE)" from customer2 where GRADE>2 group by CUST_COUNTRY;

select CUST_COUNTRY, count(GRADE) as "COUNT(GRADE)" from customer2 group by CUST_COUNTRY having count(GRADE)>=2;