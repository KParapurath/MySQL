create database library;
use library;
create table branch(
br_no int primary key,
manager_id int,
br_add varchar(100),
contact_no int
);
insert into branch (br_no,manager_id,br_add,contact_no) values
(1,10,'Thrissur,India',11111),
(2,20,'Kochi,India',22222),
(3,30,'Kollam,India',33333);
create table employee(
emp_id int primary key,
emp_name varchar(50),
pos varchar(50),
salary int,
branch_no int,
foreign key (branch_no) references branch(br_no)
);
insert into employee(emp_id,emp_name,pos,salary,branch_no) values
(10,'Kapoor','Manager',90000,1),
(14,'Vikas','Junior',40000,1),
(15,'Jikas','Junior',39000,1),
(16,'Bikas','Junior',38000,1),
(17,'Dikas','Junior',37000,1),
(18,'Tikas','Junior',36000,1),
(23,'Singh','Senior',75000,2),
(36,'Mukherjee','Expert',85000,3);
create table books(
isbn int primary key,
bk_tt varchar(100),
category varchar(50),
rent int,
stat varchar(20),
author varchar(50),
publisher varchar(50)
);
insert into books(isbn,bk_tt,category,rent,stat,author,publisher) values
(1003,'aaaa','History',20,'Y','aa','aaa'),
(2006,'bbbb','Fiction',30,'Y','bb','bbb'),
(3008,'cccc','Science',35,'Y','cc','ccc');
create table customer(
c_id int primary key,
c_name varchar(50),
c_add varchar(50),
reg_date date default('2020-06-01')
);
insert into customer(c_id,c_name,c_add,reg_date) values
(100,'Peter','Thrissur,India','2023-07-04'),
(200,'Thomas','Kochi,India',default),
(300,'Hank','Kollam,India','2023-01-01');
create table issuestatus(
issue_id int primary key,
issued_cus int,
foreign key (issued_cus) references customer(c_id),
issued_bktt varchar(100),
issue_date date,
isbn_book int,
foreign key (isbn_book) references books(isbn)
);
insert into issuestatus(issue_id,issued_cus,issued_bktt,issue_date,isbn_book) values
(10,100,'aaaa','2022-01-01',1003),
(30,300,'bbbb','2023-06-03',2006);
create table returnstatus(
r_id int primary key,
r_cus int,
r_bookname varchar(50),
r_date date,
isbn_book2 int,
foreign key (isbn_book2) references books(isbn)
);
insert into returnstatus(r_id,r_cus,r_bookname,r_date,isbn_book2) values
(01,100,'aaaa','2022-01-30',1003),
(03,300,'bbbb','2023-06-30',2006);
desc branch;
select * from branch;
desc employee;
select * from employee;
desc books;
select * from books;
desc customer;
select * from customer;
desc issuestatus;
select * from issuestatus;
desc returnstatus;
select * from returnstatus;
select bk_tt, rent, category from books;
select emp_name,salary from employee order by salary desc;
select issued_cus as Customer_id,(select c_name from customer where c_id = Customer_id) as Customer,issued_bktt from issuestatus;
select category,count(distinct category) as No_of_Books from books group by isbn;
select emp_name,pos from employee where salary>50000;
select customer.c_name,customer.reg_date
from customer inner join issuestatus on
issuestatus.issued_cus != customer.c_id where customer.reg_date<'2022-01-01';
select branch_no as Branch,count(distinct emp_id) as EmployeeCount from employee group by branch_no;
select customer.c_id as ID,customer.c_name as Name,issuestatus.issue_date as Date
from customer inner join issuestatus on
issuestatus.issued_cus = customer.c_id where issuestatus.issue_date between '2023-06-01' and '2023-06-30';
select bk_tt from books where category = 'History';
select branch_no as Branch,count(distinct emp_id) as EmployeeCount from employee group by branch_no having count(distinct emp_id)>5;
select branch.manager_id as ID,branch.br_add as Address,employee.emp_name as EmployeeName
from employee inner join branch on
employee.branch_no = branch.br_no where branch.manager_id=employee.emp_id;
select issuestatus.issued_cus as ID,customer.c_name CustomerName,books.rent as Rent
from issuestatus 
inner join customer 
on issuestatus.issued_cus = customer.c_id
inner join books
on issuestatus.isbn_book=books.isbn where books.rent>25;