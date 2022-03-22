use NC4

---------------Assignment 1-------------------------
---------------creating tables----------------------
create table salesman(
salesman_id numeric(5) primary key,
name varchar(30),
city varchar(20),
commission decimal(5,2))

create table customer(
customer_id numeric(5) primary key,
cust_name varchar(30),
city varchar(15),
grade numeric(3),
salesman_id numeric(5) foreign key references salesman(salesman_id))

create table orders(
ord_no numeric(5) primary key,
purch_amt decimal(8,2),
ord_date date,
customer_id numeric(5) foreign key references customer(customer_id),
salesman_id numeric(5) foreign key references salesman(salesman_id))

-----------------------inserting data--------------------------------
insert into salesman values(5001,'James Hoog','New York',0.15)
insert into salesman values(5002,'Nail Knite','Paris',0.13)
insert into salesman values(5005,'Pit Alex','London',0.11)
insert into salesman values(5006,'Mc Lyon','Paris',0.14)
insert into salesman values(5007,'Paul Adam','Rome',0.13)
insert into salesman values(5003,'Lauson Hen','San Jose',0.12)

select * from salesman;

insert into customer values(3002,'Nick Rimando','New York',100,5001)
insert into customer values(3007,'Brad Davis','New York',200,5001)
insert into customer values(3005,'Graham Zusi','California',200,5002)
insert into customer values(3008,'Julian Green','London',300,5002)
insert into customer values(3004,'Fabian Johnson','Paris',300,5006)
insert into customer values(3009,'Geoff Cameron','Berlin',100,5003)
insert into customer values(3003,'Jozy Altidor','Moscow',200,5007)
insert into customer(customer_id,cust_name,city,salesman_id) values(3001,'Brad Guzan','London',5005)

select * from customer;

insert into orders values(70001,150.5,'2012-10-05',3005,5002)
insert into orders values(70009,270.65,'2012-09-10',3001,5002)
insert into orders values(70002,65.26,'2012-10-05',3002,5001)
insert into orders values(70004,110.5,'2012-08-17',3009,5003)
insert into orders values(70007,948.5,'2012-09-10',3005,5002)
insert into orders values(70005,2400.6,'2012-07-27',3007,5001)
insert into orders values(70008,5760,'2012-09-10',3002,5001)
insert into orders values(70010,1983.43,'2012-10-10',3004,5006)
insert into orders values(70003,2480.4,'2012-10-05',3009,5003)
insert into orders values(70012,250.45,'2012-06-27',3008,5002)
insert into orders values(70011,75.29,'2012-08-17',3003,5007)
insert into orders values(70013,3045.6,'2012-04-25',3002,5001)

select * from orders;

--1.Write a query to display the columns in a specific order like order date,salesman id, order number and purchase amount from for all the orders-----
	select ord_date,salesman_id,ord_no,purch_amt from orders

--2.write a SQL query to find the unique salespeople ID. Return salesman_id.----
	select distinct(salesman_id) from salesman

--3.write a SQL query to find the salespeople who lives in the City of 'Paris';.Return salesperson's name, city----
	select name,city from salesman where city = 'Paris'

--4.write a SQL query to find the orders, which are delivered by a salesperson of ID. 5001. Return ord_no, ord_date, purch_amt----
	select ord_no,ord_date,purch_amt from orders where salesman_id=5001

--5.write a SQL query to find all the customers in ‘New York’ city who have a grade value above 100. Return customer_id, cust_name, city, grade, and salesman_id.---
	select cust_name, city,grade,salesman_id from customer where city='New York'

--6.write a SQL query to find the details of those salespeople whose commissions range from 0.10 to0.12. Return salesman_id, name, city, and commission--
	select salesman_id,name,city,commission from salesman where commission between 0.10 and 0.12

--7.write a SQL query to calculate total purchase amount of all orders. Return total purchase amount.---
	select sum(purch_amt) as 'Total purchase amount' from orders

--8.write a SQL query to calculate average purchase amount of all orders. Return average purchase amount.---
	select avg(purch_amt) as 'Average purchase amount' from orders

--9.write a SQL query to count the number of unique salespeople. Return number of salespeople.---
	select count(salesman_id) as 'Number of salespeople' from salesman

--10.write a SQL query to find the highest purchase amount ordered by each customer. Return customer ID, maximum purchase amount-----
	select customer_id,max(purch_amt) as 'Maximum puechase amount' from orders group by customer_id

--11.write a SQL query to find the highest purchase amount ordered by each customer on a particular date. Return, order date and highest purchase amount---
	select ord_date,max(purch_amt) as 'Maximum puechase amount' from orders group by ord_date

--12.write a SQL query to find the highest purchase amount on '2012-08- 17' by each salesperson. Return salesperson ID, purchase amount.-----
	select salesman_id,max(purch_amt) from orders where ord_date='2012-08-17'  group by salesman_id 

--13.write a SQL query to find the salesperson and customer who belongs to same city. Return Salesman, cust_name and city.---
	select customer.cust_name as 'Customer_Name',salesman.name as 'Salesman_Name',customer.city as 'Cust city',salesman.city as 'Salesman city' from customer,salesman where customer.city = salesman.city

--14.write a SQL query to find those orders where order amount exists between 500 and 2000. Return ord_no, purch_amt, cust_name, city-----
	select ord_no,purch_amt,customer.cust_name as 'Cust_name',customer.city as 'Customer city' from orders,customer where purch_amt between 500 and 2000

--15.write a SQL query to find those salespersons who received a commission from the company more than 12%. Return Customer Name, customer city, Salesman, commission----
	select customer.cust_name,customer.city,salesman.name,salesman.commission from customer,salesman where salesman.commission >0.12 

--16.write a SQL query to display the cust_name, customer city, grade, Salesman, salesman city. The result should be ordered by ascending on customer_id.-----
	select customer.customer_id, customer.cust_name,customer.city,customer.grade,salesman.name,salesman.city from customer,salesman order by customer.customer_id asc
