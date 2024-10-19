# Challenge 2 - Esports Tournament 

# **Relationship Diagram**
![image](https://github.com/user-attachments/assets/cca9858d-9009-450c-af1f-d8e4012db566)

# **Data preview**
Teams table:
\
![image](https://github.com/user-attachments/assets/7c56cc47-71ba-40c8-9e02-70eb3421a7c9)
\
Players table:
\
![image](https://github.com/user-attachments/assets/930bcf03-7961-49fc-92b2-5b20c9fe71b3)
\
Matches table:
\
![image](https://github.com/user-attachments/assets/a7957821-243e-450e-b9d0-2f1ab8985c4d)
\
# **Solutions**

**1. What are the names of the players whose salary is greater than 100,000?**

```sql
select player_id, player_name, salary 
from Players
where salary >= 100000;
```
Output:
\
![image](https://github.com/user-attachments/assets/98015eb4-fadc-48a7-8816-168bdaf4af00)

**2. What is the team name of the player with player_id = 3?**

```sql
select p.team_id, team_name 
from Players p
join Teams t on p.team_id = t.team_id
where player_id = 3;
```
Output:
\
![image](https://github.com/user-attachments/assets/53ebcbfe-b5fc-490a-893e-11327bbf4428)

**3. What is the total number of players in each team?**

```sql
select p.team_id, team_name, count(player_id) amount 
from Players p
join Teams t on p.team_id = t.team_id
group by p.team_id, team_name;
```
Output:
\
![image](https://github.com/user-attachments/assets/1dd3e845-80fc-4c2e-a68f-a7856264c71e)

**4. What is the team name and captain name of the team with team_id = 2?**

```sql
select team_name, player_name, t.team_id 
from Teams t
join Players p on t.captain_id = p.player_id
where t.team_id = 2;
```
Output:
\
![image](https://github.com/user-attachments/assets/58597b78-1f75-49ff-a1bc-c165df201fa7)

**5. What are the player names and their roles in the team with team_id = 1?**

```sql
select player_name, role, team_id 
from Players
where team_id = 1;
```
Output:
\
![image](https://github.com/user-attachments/assets/61aacf7a-6faa-4f29-9e0f-6b5405d8578d)

**6. What are the team names and the number of matches they have won?**

```sql
select winner_id, team_name, count(winner_id) amount 
from Matches m
join Teams t on t.team_id = m.winner_id
group by winner_id, team_name;
```
Output:
\
![image](https://github.com/user-attachments/assets/f147175d-2a66-4e17-8808-fdd46ad19abc)

**7. What is the average salary of players in the teams with country ‘USA’?**

```sql
select p.team_id, team_name, sum(salary) / count(player_id) salary_avg 
from Players p
join Teams t on p.team_id = t.team_id
where country = 'USA'
group by p.team_id, team_name;
```
Output:
\
![image](https://github.com/user-attachments/assets/ec9fb7c9-c7db-4d20-b8fc-61a721ffeabd)

**8. Which team won the most matches?**

```sql
select top 1 winner_id, team_name, count(winner_id) amount 
from Matches m
join Teams t on t.team_id = m.winner_id
group by winner_id, team_name
order by amount desc;
```
Output:
\
![image](https://github.com/user-attachments/assets/47a9bda8-6bee-470f-a894-68790967ba21)

**9. What are the team names and the number of players in each team whose salary is greater than 100,000?**

```sql
select p.team_id, team_name, count(player_id) amount 
from Players p
join Teams t on p.team_id = t.team_id
where salary >= 100000
group by p.team_id, team_name;
```
Output:
\
![image](https://github.com/user-attachments/assets/1e95f2ea-d145-4385-a5d4-fe7571e145c0)

**10. What is the date and the score of the match with match_id = 3?**

```sql
select match_date, score_team1, score_team2 
from Matches
where match_id = 3;
```
Output:
\
![image](https://github.com/user-attachments/assets/6343a961-55b6-4420-99bf-d1267024505c)


