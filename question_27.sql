CREATE TABLE students(
 studentid int,
 studentname nvarchar(255) NULL,
 subject nvarchar(255) NULL,
 marks int NULL,
 testid int NULL,
 testdate date NULL
)

insert into students values (2,'Max Ruin','Subject1',63,1,'2022-01-02');
insert into students values (3,'Arnold','Subject1',95,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject1',61,1,'2022-01-02');
insert into students values (5,'John Mike','Subject1',91,1,'2022-01-02');
insert into students values (4,'Krish Star','Subject2',71,1,'2022-01-02');
insert into students values (3,'Arnold','Subject2',32,1,'2022-01-02');
insert into students values (5,'John Mike','Subject2',61,2,'2022-11-02');
insert into students values (1,'John Deo','Subject2',60,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject2',84,1,'2022-01-02');
insert into students values (2,'Max Ruin','Subject3',29,3,'2022-01-03');
insert into students values (5,'John Mike','Subject3',98,2,'2022-11-02');

select * from students

-- write a query to find the list of students who have scored more than avg in all subjects

with avg_sub as (select subject, avg(marks) as avg_marks from students group by subject)

select s.studentid,s.studentname,avg_sub.subject from students s inner join avg_sub on s.subject=avg_sub.subject
where s.marks >= avg_sub.avg_marks


-- write a query to get the percentage of students who score more then 90 in any subject amoungts the total students 

select (select count(distinct studentid) from students where marks> 90)*100.0/( select count(distinct studentid) from students) as percentage_above_90
from students limit 1

-- simple and smart way of doing the same 

select count(distinct case when marks>90 then studentid else null end)*100.0/count(distinct studentid) 
as perc from students

-- write a query to get the second highest and second lowest marks in each subject

-- first approach using row_number function and joining two table which has second highest and second lowest marks
select t1.subject , second_high ,second_low from
(with sub_marks as(select distinct subject , marks from students)
select subject,marks as second_high from 
(select *,row_number() over(partition by subject order by marks desc) as rn_desc
from sub_marks) as temp
where rn_desc=2) as t1
inner join 
(with sub_marks as(select distinct subject , marks from students)
select subject,marks as second_low from 
(select *,row_number() over(partition by subject order by marks asc) as rn_asc
from sub_marks) as temp
where rn_asc=2) as t2 
on t1.subject=t2.subject


-- there is great way to solve the above question 
select subject , sum(case when rn_asc=2 then marks  else null end) as second_low,
sum(case when rn_desc=2 then marks else null end) as second_high from
(select subject , marks , ROW_NUMBER() over(partition by subject order  by marks asc) as rn_asc
, ROW_NUMBER() over(partition by subject order by marks desc) as rn_desc
from students) as temp
group by subject



-- for each student and test identify if there marks has increased or decreased from the previous test.

select studentid, studentname,marks,pre_marks ,case when marks>pre_marks then 'increased' else 'decreased' end as performance
from
(select * ,
lag(marks) over(partition by studentid order by subject,testdate) as pre_marks
from students) as temp
order by studentid,testdate