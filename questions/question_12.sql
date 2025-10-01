 Where we need to find second most recent activity and if user has only 1 activoty then return that as it is. We will use SQL window functions to solve this problem.

Here is the script:

create table UserActivity
(
username      varchar(20) ,
activity      varchar(20),
startDate     Date   ,
endDate      Date
);

insert into UserActivity values 
('Alice','Travel','2020-02-12','2020-02-20')
,('Alice','Dancing','2020-02-21','2020-02-23')
,('Alice','Travel','2020-02-24','2020-02-28')
,('Bob','Travel','2020-02-11','2020-02-18');


--my approcach
with cte as
(select username,max(rnk) as mxrk from
(select *,
rank() over(partition by username order by endDate desc) as rnk 
from UserActivity)
as TEMP
group by username)

select ua.* from 
(select *,
rank() over(partition by username order by endDate desc) as rnk 
from UserActivity) as
ua inner join cte  ON
ua.username=cte.username
where rnk = case when mxrk>2 then 2 end
or case when mxrk=1 then 1 end

--ankit approach

with cte as 
(select *,
count(1) over(partition by username) as total_activity,
rank() over(partition by username order by enddate desc) as rnk
from userActivity)

select * from cte total_activity=1 OR
rnk =2