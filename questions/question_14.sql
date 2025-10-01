-- user purchase platform
the table logs the spending history of users that purchases from an online shopping website which has a destop and a mobile application.
write an sql query to find the total number of user and the total amount spent using moble only , destop only and both mobile and destop together for each date . 


create table spending (
    user_id int,
    spend_date date,
    platform varchar(10),
    amount int
);

insert into
    spending
values (
        1,
        '2019-07-01',
        'mobile',
        100
    ),
    (
        1,
        '2019-07-01',
        'desktop',
        100
    ),
    (
        2,
        '2019-07-01',
        'mobile',
        100
    ),
    (
        2,
        '2019-07-02',
        'mobile',
        100
    ),
    (
        3,
        '2019-07-01',
        'desktop',
        100
    ),
    (
        3,
        '2019-07-02',
        'desktop',
        100
    );


for each day 
1. count only mobile user and there total amount
2. count ony desktop user and there total amount
3. count user used both and there amount

with all_spend as 
(
-- user used single device on that day
select
    spend_date,
    user_id,
    sum(amount) as amount,
    max(platform) as platform
from spending
group by
    user_id,
    spend_date
having
    count(distinct platform) = 1

union all
-- user used both device on that day

select
    spend_date,
    user_id,
    sum(amount) as amount,
    'both' as platform
from spending
group by
    user_id,
    spend_date
having
    count(DISTINCT platform) = 2

-- insert a dummy record
union ALL
select distinct
    spend_date,
    null as user_id,
    0 as amount,
    'both' as platform
from spending



)

select spend_date, count(user_id), platform, sum(amount) as amount
from all_spend
group by
    spend_date,
    platform