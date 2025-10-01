create table users (
    user_id int,
    join_date date,
    favorite_brand varchar(50)
);

create table orders (
    order_id int,
    order_date date,
    item_id int,
    buyer_id int,
    seller_id int
);

create table items (
    item_id int,
    item_brand varchar(50)
);

insert into
    users
values (1, '2019-01-01', 'Lenovo'),
    (2, '2019-02-09', 'Samsung'),
    (3, '2019-01-19', 'LG'),
    (4, '2019-05-21', 'HP');

insert into
    items
values (1, 'Samsung'),
    (2, 'Lenovo'),
    (3, 'LG'),
    (4, 'HP');

insert into
    orders
values (1, '2019-08-01', 4, 1, 2),
    (2, '2019-08-02', 2, 1, 3),
    (3, '2019-08-03', 3, 2, 3),
    (4, '2019-08-04', 1, 4, 2),
    (5, '2019-08-04', 1, 3, 4),
    (6, '2019-08-05', 2, 2, 4);

select * from users select * from items select * from orders;

with
    sales_item as (
        select *
        from (
                select o.seller_id, o.item_id, i.item_brand, rank() over (
                        partition by
                            o.seller_id
                        order by o.order_date
                    ) as rnk
                from orders o
                    inner join items i on i.item_id = o.item_id
            ) as t1
        where
            rnk = 2
    )

select
    u.user_id,
    case
        when si.item_brand = u.favorite_brand then 'yes'
        else 'no'
    end as favorite_brand
from users u
    left join sales_item si on u.user_id = si.seller_id