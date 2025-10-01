we have a table containing each day order and cutomer ordered,
write a query to find eac day new customer and repeated customer count.

create table customer_orders (
order_id integer,
customer_id integer,
order_date date,
order_amount integer
);
select * from customer_orders
insert into customer_orders values(1,100,cast('2022-01-01' as date),2000),(2,200,cast('2022-01-01' as date),2500),(3,300,cast('2022-01-01' as date),2100)
,(4,100,cast('2022-01-02' as date),2000),(5,400,cast('2022-01-02' as date),2200),(6,500,cast('2022-01-02' as date),2700)
,(7,100,cast('2022-01-03' as date),3000),(8,400,cast('2022-01-03' as date),1000),(9,600,cast('2022-01-03' as date),3000)
;


with
    cust_date as (
        select customer_id, min(order_date) as first_date
        from customer_orders
        group by
            customer_id
    )

select
    order_date,
    sum(
        case
            when order_date = first_date then 1
        end
    ) as new_customer,
    sum(
        case
            when order_date <> first_date then 1
        end
    ) as repeted_customer
from
    customer_orders co
    inner join cust_date cd on co.customer_id = cd.customer_id
group by
    co.order_date