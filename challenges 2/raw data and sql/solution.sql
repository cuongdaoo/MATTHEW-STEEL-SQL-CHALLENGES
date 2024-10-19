select * from [dbo].[Teams];
select * from [dbo].[Players];
select * from [dbo].[Matches];

--- 1.What are the names of the players whose salary is greater than 100,000?
select player_id,player_name, salary from Players
where salary >=100000;

-- 2. What is the team name of the player with player_id = 3?
select p.team_id, team_name from Players p
join Teams t on p.team_id=t.team_id
where player_id=3;

-- 3. What is the total number of players in each team?
select p.team_id, team_name, count(player_id) amount from Players p
join Teams t on p.team_id=t.team_id
group by p.team_id, team_name;

-- 4. What is the team name and captain name of the team with team_id = 2?
select team_name, player_name, t.team_id from Teams t
join Players p on t.captain_id=p.player_id
where t.team_id=2;

-- 5. What are the player names and their roles in the team with team_id = 1?
select player_name, role, team_id from Players
where team_id =1;

-- 6. What are the team names and the number of matches they have won?
select winner_id, team_name, count(winner_id) amount from Matches m
join Teams t on t.team_id=m.winner_id
group by winner_id, team_name;

-- 7. What is the average salary of players in the teams with country ‘USA’?
select p.team_id, team_name, sum(salary)/count(player_id) salary_avg from Players p
join Teams t on p.team_id=t.team_id
where country='USA'
group by p.team_id, team_name;

-- 8. Which team won the most matches?
select top 1 winner_id, team_name, count(winner_id) amount from Matches m
join Teams t on t.team_id=m.winner_id
group by winner_id, team_name
order by amount desc;

-- 9. What are the team names and the number of players in each team whose salary is greater than 100,000?
select p.team_id, team_name, count(player_id) amount from Players p
join Teams t on p.team_id=t.team_id
where salary >= 100000
group by p.team_id, team_name;

-- 10. What is the date and the score of the match with match_id = 3?
select match_date, score_team1, score_team2 from Matches
where match_id =3;