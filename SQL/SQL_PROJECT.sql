
											/*SQL PROJECT */

drop table if exists dept;

CREATE TABLE dept (
    Deptno INT(2) NOT NULL PRIMARY KEY,
    Dname VARCHAR(14),
    Loc VARCHAR(13)
);


INSERT INTO dept (Deptno, Dname, Loc) 
 VALUES(10, 'ACCOUNTING', 'NEW YORK'),
(20, 'RESEARCH', 'DALLAS'),
(30, 'SALES', 'CHICAGO');

drop table if exists emp;

CREATE TABLE emp (
    Empno INT(4) NOT NULL PRIMARY KEY DEFAULT 0,
    Ename VARCHAR(10),
    Job VARCHAR(9),
    Mgr INT(4),
    Hiredate DATE,
    Sal DECIMAL(7,2),
    Comm DECIMAL(7,2),
    Deptno INT(2),
    FOREIGN KEY (Deptno) REFERENCES dept(Deptno)
);


INSERT INTO emp (Empno, Ename, Job, Mgr, Hiredate, Sal, Comm, Deptno) VALUES
(7369, 'SMITH', 'CLERK', 7902, '1980-12-17', 800.00, NULL, 20),
(7499, 'ALLEN', 'SALESMAN', 7698, '1981-02-20', 1600.00, 300.00, 30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-06-11', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-08-09', 1500.00, 0.00, 30);

/*1. Select unique job from EMP table. */ 

SELECT DISTINCT job FROM   emp;

/*2. List the details of the emps in asc order of the Dptnos and desc of Jobs? */
SELECT * FROM   emp
ORDER  BY deptno ASC, job DESC;

/*3. Display all the unique job groups in the descending order? */ 

SELECT DISTINCT job FROM   emp
ORDER  BY job DESC;

/*4. List the emps who joined before 1981. */

SELECT * FROM   emp
WHERE  hiredate < DATE '1981-01-01';

/*5. List the Empno, Ename, Sal, Daily sal of all emps in the asc order of 
Annsal.*/

SELECT empno, ename, sal,(sal/30) FROM   emp
ORDER  BY sal *12;

/*6. List the Empno, Ename, Sal, Exp of all emps working for Mgr 7369. */

SELECT empno, ename, sal,hiredate,
	timestampdiff(year,hiredate,curdate()) as exp
FROM   emp
WHERE  mgr = 7902;

/*7. Display all the details of the emps who’s Comm. Is more than their Sal? */

select * from emp
where comm > sal;

/*8. List the emps who are either ‘CLERK’ or ‘ANALYST’ in the Desc order. */

select * from emp
where job in ('CLERK','ANALYST')
order by Ename desc;

/*9. List the emps Who Annual sal ranging from 22000 and 45000. */

select * from emp 
where sal*12 between 22000 and 45000;

/*10. List the Enames those are starting with ‘S’ and with five characters. */

select * from emp
where Ename like 'S____';

/*11. List the emps whose Empno not starting with digit78. */

select * from emp
where empno not like '78%';

/*12. List all the Clerks of Deptno 20. */

select * from emp
where deptno=20;

/*13. List the Emps who are senior to their own MGRS. */

select e.empno,e.ename,e.hiredate,
m.empno as mgrno,m.ename as mgrname,m.hiredate as mgr_hiredate
from emp e
join emp m
on e.mgr = m.empno
where e.hiredate < m.hiredate;

/*14. List the Emps of Deptno 20 who’s Jobs are same as Deptno10. */

select * from emp
where deptno=20 and job
in (select distinct job from emp where deptno=10);

/*15. List the Emps who’s Sal is same as FORD or SMITH in desc order of Sal. */

select * from emp
where sal in
(select sal from emp where ename in ('ford','smith'))
order by sal desc;

/*16. List the emps whose jobs same as SMITH or ALLEN */

select * from emp
where job in (select job from emp where ename in ('smith','allen'));

/*17. Any jobs of deptno 10 those that are not found in deptno 20. */
 
select job from emp
where deptno=10 and
job not in(select job from emp where deptno=20);

/*18. Find the highest sal of EMP table. */

select max(sal) as highest_sal from emp;

/*19. Find details of highest paid employee. */

select * from emp
order by sal desc
limit 1;

/*20. Find the total sal given to the MGR. */

select sum(sal) as total_sal from emp
where job='manager';

/*21. List the emps whose names contains ‘A’. */

select * from emp
where ename like '%A%';
/*22. Find all the emps who earn the minimum Salary for each job wise in 
ascending order. */

select * from emp e
where sal=(select min(sal) from emp
where job=e.job)
order by job asc;

/*23. List the emps whose sal greater than Blake’s sal. */

select * from emp
where sal>(select sal from emp where ename='blake');

/*24. Create view v1 to select ename, job, dname, loc whose deptno are 
same. */

create view v1 as
select e.ename,e.job,d.dname,d.loc
from emp e
join dept d
on e.deptno=d.deptno;

select * from v1;

/*25. Create a procedure with dno as input parameter to fetch ename and 
dname. */

Delimiter $$

create procedure study(in dno int)
begin
	select emp.ename,dept.dname
    from emp
    join dept
    on emp.deptno=dept.deptno
    where emp.deptno=dno;
end $$
Delimiter ;

call study(30);

/*26. Add column Pin with bigint data type in table student. */

select * from student;

alter table student
add pin bigint;

/*27. Modify the student table to change the sname length from 14 to 40. 
Create trigger to insert data in emp_log table whenever any update of sal 
in EMP table. You can set action as ‘New Salary’. */

Delimiter //
create trigger NNN
after update on emp
for each row
begin
	if old.sal =new.sal then 
insert into EMPLOG (emp_id,log_date,new_salary,action)
values(old.empno,now(),new.sal,'new salary');
end if;
	end//
    Delimiter ;
    
    update emp
    set sal=1000
    where empno =7369;