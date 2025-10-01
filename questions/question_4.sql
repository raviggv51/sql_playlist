write a query to sumarize the start and end date for all the task , if 1st to 4th are sucess
then out should be startdate 1st enddate 4th and status as sucess.

create table tasks (
date_value date,
state varchar(10)
);

insert into tasks  values 
('2019-01-01','success'),
('2019-01-02','success'),
('2019-01-03','success'),
('2019-01-04','fail'),
('2019-01-05','fail'),
('2019-01-06','success')

with group_task as
(select *, row_number() over(partition by state order by date_value) as rnk,
dateadd(day,-1*row_number() over ( partition by state order by date_value ),date_value) as group_date
from tasks
)
select tasks, min(date_value) as start_date,max(date_value) as end_date,
from group_tasks
group by group_date,tasks