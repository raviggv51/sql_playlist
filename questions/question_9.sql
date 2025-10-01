The Pareto principle state that for many outcomes, roughly 80% of consequences come from 20% of causes.
example:
1. 80% of the productivity come from 20% of the employees.
2. 80% of your sales come from 20% of your clients
3. 80% of decisions in a meeting are made in 20% of the time
4. 80% of your sales come from 20% of your products or services.

dataset link : https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqblZoSzlEeGpSd2RieEJVellmdzU5bW1QcjRId3xBQ3Jtc0tudkFpMDhOdkROU0N4NmNNY0lfMWtyVTZqSGRkT3FWTXFFdTRKOTljTmRQNFJUV0FNM2hYTHlIVVpobXd6RzlEVjRJN3VIQlM4SWtxZWhyRmIxWW45UFRYS2RmOGhnR29SNHBEdDhTaml1MXAzamg1UQ&q=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1Dc81McsB4lp1JUIwssDmmOaw6Z7rBK8T&v=oGgE180oaTs

order(product_id,name,order_date,sale)
<!-- total sale -->
select sum(sale) from order

<!-- product sales -->
with product_sales as
(select product_id,sum(sale) as product_sale from order group by product_id)

<!-- will add running sales sum using window function -->
with products_runing_sales
(select product_id, 
sum(sale) over(order by product_sale desc
row between unbound preceding and current row
) as running_sum,
sum(sales) over() as total_sale
from product_sales)

select * from products_running_sales where total_sale*0.8 < running_sum

<!-- row between unbound preceding and current row -->
This clause defines the window frame — the set of rows that the window function (like SUM) will operate on for each row.

ROWS: Operate on physical rows (not value ranges).
UNBOUNDED PRECEDING: Start from the first row in the partition.
CURRENT ROW: End at the current row being processed.

So for each row, SQL will:

Look at all rows from the top of the ordered set
Down to the current row
And apply the function (like SUM) on that subset

<!-- Without this clause, SQL might default to a different frame (like RANGE), which can behave unexpectedly — especially with duplicate values. Using ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW ensures: -->

Precise control
Consistent results
Correct running totals