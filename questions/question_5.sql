you are given a table containing oppenets and te winner 
write a query to find the number of matches played by each team there win count and loss count.


create table icc_world_cup
(
Team_1 Varchar(20),
Team_2 Varchar(20),
Winner Varchar(20)
);
INSERT INTO icc_world_cup values('India','SL','India');
INSERT INTO icc_world_cup values('SL','Aus','Aus');
INSERT INTO icc_world_cup values('SA','Eng','Eng');
INSERT INTO icc_world_cup values('Eng','NZ','NZ');
INSERT INTO icc_world_cup values('Aus','India','India');

select * from icc_world_cup;


with
    cte_teams as (
        select
            team_1 as team,
            case
                when winner = team_1 then 1
                else 0
            end as win_flag
        from icc_world_cup
        union all
        select
            team_2 as team,
            case
                when winner = team_2 then 1
                else 0
            end as win_flag
        from icc_world_cup
    )

select team, count(*) as match, sum(win_flag) as win, count(*) - sum(win_flag) as loss
from cte_teams
group by
    team
order by team desc
