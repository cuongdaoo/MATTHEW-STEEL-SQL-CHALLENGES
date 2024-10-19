# Challenge 5- Pub Pricing analysis

# **Relationship Diagram**
![image](https://github.com/user-attachments/assets/12b60121-25e7-48f0-862b-104d36a395f4)

# **Data preview**
Pubs table:
\
![image](https://github.com/user-attachments/assets/1d2a012a-2787-47d8-a2e9-3bb0ace5ab3d)
\
Beverages table:
\
![image](https://github.com/user-attachments/assets/df34a3a3-85ca-4d42-a059-748b05d3c2e6)
\
Sales table:
\
![image](https://github.com/user-attachments/assets/63001a45-c0da-416f-8d11-2e101f95f9d3)
\
Ratings table:
\
![image](https://github.com/user-attachments/assets/07417171-ea24-44c8-8037-4d677c9bc114)

# **Solutions**

**1. How many pubs are located in each country?**

```sql
select country, count(pub_id) amount from pubs
group by country;
```
Output:
\
![image](https://github.com/user-attachments/assets/89824c93-696c-4c11-9a18-a9d265088623)

**2. What is the total sales amount for each pub, including the beverage price and quantity sold?**

```sql
select p.pub_id, sum(price_per_unit * quantity) total_sales 
from pubs p
join sales s on s.pub_id = p.pub_id
join beverages b on b.beverage_id = s.beverage_id
group by p.pub_id;
```
Output:
\
![image](https://github.com/user-attachments/assets/d7a4eaf2-3624-4adc-87d5-abf562c02f40)

**3. Which pub has the highest average rating?**

```sql
select pub_id, avg(rating) avg_rating 
from ratings
group by pub_id
order by avg_rating desc
limit 1;
```
Output:
\
![image](https://github.com/user-attachments/assets/b435717a-444f-43ce-abea-df0060af9493)

**4. What are the top 5 beverages by sales quantity across all pubs?**

```sql
select top 5 beverage_name, sum(quantity) total 
from sales s
join beverages b on b.beverage_id = s.beverage_id
group by beverage_name
order by total desc;
```
Output:
\
![image](https://github.com/user-attachments/assets/8c9cf9e4-5701-42fb-9ef2-3daa436cf929)

**5. How many sales transactions occurred on each date?**

```sql
select transaction_date, count(transaction_id) trans_count 
from sales
group by transaction_date;
```
Output:
\
![image](https://github.com/user-attachments/assets/991c18a4-e3f7-457a-95d0-9e1f7b8e9135)

**6. Find the name of someone that had cocktails and which pub they had it in.**

```sql
select p.pub_name, customer_name, category 
from pubs p
join sales s on s.pub_id = p.pub_id
join beverages b on b.beverage_id = s.beverage_id
join ratings r on r.pub_id = p.pub_id
where category = 'Cocktail';
```
Output:
\
![image](https://github.com/user-attachments/assets/95d40330-b799-4a7a-8b6a-8afe2b1f7512)

**7. What is the average price per unit for each category of beverages, excluding the category ‘Spirit’?**

```sql
select category, avg(price_per_unit) as average_price 
from beverages
where category != 'Spirit'
group by category;
```
Output:
\
![image](https://github.com/user-attachments/assets/ac90ddb9-d44a-4dba-b274-0e6bfdb6a1a8)

**8. Which pubs have a rating higher than the average rating of all pubs?**

```sql
select pub_name, avg(rating) avg_rating_higher 
from ratings r
join pubs p on p.pub_id = r.pub_id
group by pub_name
having avg(rating) > (select avg(rating) from ratings);
```
Output:
\
![image](https://github.com/user-attachments/assets/51097ec7-d815-4339-b827-a30d8f199f45)

**9. What is the running total of sales amount for each pub, ordered by the transaction date?**

```sql
select p.pub_id, p.pub_name, transaction_date, sum(price_per_unit * quantity) total_sales 
from pubs p
join sales s on s.pub_id = p.pub_id
join beverages b on b.beverage_id = s.beverage_id
group by p.pub_id, p.pub_name, transaction_date
order by transaction_date;
```
Output:
\
![image](https://github.com/user-attachments/assets/912a2680-af7a-4391-a07d-eb3e6779c72c)

**10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?**

```sql
select country, category, round(avg(price_per_unit), 1) avg_price, 
avg(round(avg(price_per_unit), 1)) over (partition by category) avg_price_category 
from pubs p
join sales s on s.pub_id = p.pub_id
join beverages b on b.beverage_id = s.beverage_id
group by country, category;
```
Output:
\
![image](https://github.com/user-attachments/assets/3efdb9bd-9711-48db-9c09-effce36ca8c5)

