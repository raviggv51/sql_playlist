Write an sql query to find the winner in each group.
the winner in each group is the player who scored the maximum total points within the group. In the case of a tie the lowest player_id wins.


create table players
(player_id int,
group_id int)

insert into players values (15,1);
insert into players values (25,1);
insert into players values (30,1);
insert into players values (45,1);
insert into players values (10,2);
insert into players values (35,2);
insert into players values (50,2);
insert into players values (20,3);
insert into players values (40,3);

create table matches
(
match_id int,
first_player int,
second_player int,
first_score int,
second_score int)

insert into matches values (1,15,45,3,0);
insert into matches values (2,30,25,1,2);
insert into matches values (3,30,15,2,0);
insert into matches values (4,40,20,5,2);
insert into matches values (5,35,50,1,1);

with
    player_score as (
        select
            first_player as player_id,
            first_score as score
        from matches
        union all
        select
            second_player as player_id,
            second_Score as score
        from matches
    )

select *
from (
        select p.player_id, p.group_id, sum(ps.score) as score, rank() over (
                partition by
                    p.group_id
                order by sum(ps.score) desc, p.player_id
            ) as rnk
        from players p
            inner join player_Score ps on ps.player_id = p.player_id
        group by
            p.player_id, p.group_id
    ) as t1
where
    rnk = 1