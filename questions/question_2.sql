you have a table named entries with name of employee and can have different email,
you have to write a query to find employee favourate floor which he visited most, number of time he visited the building and resources in used in building


create table entries ( 
name varchar(20),
address varchar(20),
email varchar(20),
floor int,
resources varchar(10));

insert into entries 
values ('A','Bangalore','A@gmail.com',1,'CPU'),
('A','Bangalore','A1@gmail.com',1,'CPU'),
('A','Bangalore','A2@gmail.com',2,'DESKTOP'),
('B','Bangalore','B@gmail.com',2,'DESKTOP'),
('B','Bangalore','B1@gmail.com',2,'DESKTOP'),
('B','Bangalore','B2@gmail.com',1,'MONITOR')


with
    cte_name as (
        select
            name,
            count(*) as num_visit,
            string_agg (resources, ',') as used
        from entries
        group by
            name
    ),
    cte_2 as (
        select name, floor
        from (
                select name, floor, count(*) as cnt, row_number() over (
                        partition by
                            name
                        order by count(*) desc
                    ) as row_num
                from entries
                group by
                    name, floor
            ) as T1
        where
            row_num = 1
    )

select t1.name, t1.num_visit, t2.floor as fav_floor, t1.used
from cte_name t1
    inner join cte_2 t2 on t1.name = t2.name