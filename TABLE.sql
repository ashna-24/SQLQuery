use student;
create table department(
    dep_id int primary key,
	dep_name varchar(20),
	dep_location varchar(15)
);
select * from department;

create table salary_grade(
    grade int primary key,
	min_salary int,
	max_salary int
);
select * from department;
select * from salary_grade;

create table employees(
    emp_id int primary key,
	emp_name varchar(15),
	job_name varchar(10),
	manager_id int,
	hire_date date,
	salary dec(10,2),
	commission dec(7,2),
	dep_id int
);
select * from employees;

insert into employees
values
       (68319, 'KAYLING', 'PRESIDENT', NULL, '1991-11-18', 6000.00, null, 1001),
	   (66928, 'BLAZE', 'MANAGER', 68319, '1991-05-01', 2750.00, null, 3001),
	   (67832, 'CLARE', 'MANAGER', 68319, '1991-06-09', 2550.00, null, 1001),
       (65646, 'JONAS', 'MANAGER', 68319, '1991-04-02', 2957.00, null, 2001),
	   (67858, 'SCARLET', 'ANALYST', 65646, '1997-04-19', 3100.00, null, 2001),
       (69062, 'FRANK', 'ANALYST', 65646, '1991-12-03', 3100.00, null, 2001),
	   (63679, 'SANDRINE', 'CLERK', 69062, '1990-12-18', 900.00, null, 2001),
	   (64989, 'ADELYN', 'SALESMAN', 66928, '1991-02-20', 1700.00, 400.00, 3001),
	   (65271, 'WADE', 'SALESMAN', 66928, '1991-02-22', 1350.00, 600.00, 3001),
	   (66564, 'MADDEN', 'SALESMAN', 66928, '1991-09-28', 1350.00, 1500.00, 3001),
	   (68454, 'TUCKER', 'SALESMAN', 66928, '1991-09-08', 1600.00, 0.00, 3001),
	   (68736, 'ADNRES', 'CLERK', 67858, '1997-05-23', 1200.00, null, 2001),
	   (69000, 'JULIUS', 'CLERK', 66928, '1991-12-03', 1050.00, null, 3001),
	   (69324, 'MARKER', 'CLERK', 67832, '1992-01-23', 1400.00, null, 1001);

select salary from employees;

select distinct job_name from employees;

select emp_name, format((salary*1.15),'C','en-US') as "salary" from employees;

select emp_name+'    '+job_name as "Employee & job" from employees;

select emp_id, emp_name, salary, convert(varchar(20),hire_date, 107)as "to_char" from employees;

select len(emp_name) as "length" from employees;

select emp_id, salary, commission from employees;

select * from employees where dep_id not in('2001');

select * from employees where hire_date<'1991';

select avg(salary) as "avg" from employees where (job_name='ANALYST'); 

select * from employees where (emp_name='BLAZE');

select * from employees where (salary*1.25)> 3000;

select * from employees where month(hire_date)='01';

select emp_id, emp_name, hire_date, salary from employees where (hire_date<'1991-04-01');

insert into salary_grade values ('1',800,1300),
                                ('2',1301, 1500),
                                ('3', 1501, 2100),
								('4', 2101, 3100),
								('5', 3101, 9999);

select * from salary_grade;

select emp.emp_name, emp.salary  from employees emp, salary_grade sal where emp.emp_name='FRANK' and emp.salary between sal.min_salary and sal.max_salary and emp.salary = sal.max_salary;

select * from employees where job_name not in ('PRESIDENT','MANAGER') order by salary asc;

select max(salary) as "max" from employees;

select job_name, avg(salary) as "avg", avg(salary+commission) as "avg" from employees group by job_name;

insert into department 
values ('1001','FINANCE','SYDNEY'),
       ('2001', 'AUDIT','MELBOURNE'),
       ('3001', 'MARKETING','PERTH'),
	   ('4001', 'PRODUCTION','BRISBANE');

select * from department;

select emp.emp_id, emp.emp_name, emp.dep_id, dep.dep_location, dep.dep_name from employees emp, department dep where emp.dep_id = dep.dep_id and emp.dep_id in ('1001','2001');

select manager_id, count(*) as "count" from employees group by manager_id order by manager_id asc;

select dep_id, count(*) as "count" from employees group by dep_id having count(*)>=2;

select * from employees where emp_name like '%AR%';

alter table employees add Gender char(1);
update employees set Gender ='M'where emp_id in('63679','64989','65271','66928','68454','68736','69062');
update employees set Gender ='F'where emp_id not in('63679','64989','65271','66928','68454','68736','69062');
select * from employees;

--update employees set job_name=null where job_name in ('PRESIDENT','MANAGER');

select * from employees where job_name not in('PRESIDENT','MANAGER');

select distinct job_name,
   case when job_name in('PRESIDENT','MANAGER','ANALYST') then 'Management Level'
        when job_name in('CLERK','SALESMAN') then 'Employee Level'
   end as 'label' from employees;

update employees set commission=650.00 where job_name='ANALYST'and EXISTS(select job_name from employees where job_name='ANALYST');
select * from employees;