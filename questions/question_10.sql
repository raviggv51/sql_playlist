--  recursive CTE

with
    cte_numbers as (
        select 1 as num   -- anchor query
        union ALL
        select num + 1    -- recursive query
        from cte_numbers
        where
            num < 6       -- filter to stop the recursion
    )

select num from cte_numbers

-- anchor : 1
-- num=1  : 2
-- num=2  : 3
-- num=3  : 4
-- num=4  : 5
-- num=5  : 6  -- break of recursion

recursive CTE is mosly used to generate dummy data 
in this we used to generate dummy dates 


-- generating all the dates from min period_start to max of priod_end
with
    r_cte as (
        select min(period_start) as dates, max(period_end) as max_date
        from sales
        union ALL
        select dateadd (day, 1, dates) as dates, max_date
        from r_cte
        where
            dates < max_date
    )

-- join to sales table based on between dates and group by product_id and year
select
    product_id,
    year(dates),
    max_date,
    sum(average_daily_sales) as total_amount
from r_cte
    inner join sales on dates between period_start and period_end
group by
    product_id,
    year(dates)
order by product_id, year(dates)