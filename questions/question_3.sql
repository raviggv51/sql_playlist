write a query to find PersonID, name,number of friends, sum of marks of person who have friends with total score greater than 100.

dataset : https://www.youtube.com/redirect?event=video_description&redir_token=QUFFLUhqa012NF9IYURXRFBTUEtBOUdvc3FDLXVIRVFrZ3xBQ3Jtc0tsWXVqNDFUeWNqd0FZM05CN0xWNjhKcTNwY1dVTHJRc2tXQ0cxRFF2UlhOcUJaZ213d3BvZi1rSnhwTjd2STk0bXNZVWhMMjB5UjhGTFdQREZTQ3R4VUJSLXRYSzNzUno3WDNJQzA0UkRLNEVFR0Z2NA&q=https%3A%2F%2Fdrive.google.com%2Fdrive%2Ffolders%2F1Dc81McsB4lp1JUIwssDmmOaw6Z7rBK8T%3Fusp%3Dsharing&v=SfzbR69LquU


person(personID,name,email,score)
friend(personID,friendID)


with person_with_100 as
(
select p.personID,count(f.friendID) as num_of_friends,
sum(p.score) as friends_score
from person p inner join friend f on
p.personID=f.friendID
group by p.personID
having sum(p.score)>100
)

select p.personID,p.name,pw.num_of_friends,pw.friends_score
from person p inner join person_with_100 pw 
on p.personID=pw.personID