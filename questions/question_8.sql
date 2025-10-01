Write a query to provide the date for nth occurrence of sunday in furture from gven date


declare @today_date date;

declare @n int;

set @today_date = '2022-01-03';

set @n = 4;

-- with one dateadd
select datepart (weekday, @today_date)
select dateadd (
        day, 8 - datepart (weekday, @today_date) + (@n -1) * 7, @today_date
    )
-- with 2 dateadd
select dateadd (
        week, @n -1, dateadd (
            day, 8 - datepart (weekday, @today_date), @today_date
        )
    )

    
-- datepart – The part of the date to add to. Common values include:
-- year or yy or yyyy
-- quarter or qq or q
-- month or mm or m
-- day or dd or d
-- week or wk or ww
-- hour or hh
-- minute or mi or n
-- second or ss or s
-- millisecond or ms