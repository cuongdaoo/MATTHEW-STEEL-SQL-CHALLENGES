select * from [dbo].[pubs];
select * from [dbo].[beverages];
select * from [dbo].[sales];
select * from [dbo].[ratings];

-- 1.How many pubs are located in each country?
select country, count(pub_id) amount from pubs
group by country;

-- 2. What is the total sales amount for each pub, including the beverage price and quantity sold?
select p.pub_id, sum(price_per_unit*quantity) total_sales from pubs p
join sales s on s.pub_id=p.pub_id
join beverages b on b.beverage_id=s.beverage_id
group by p.pub_id;

-- 3. Which pub has the highest average rating?
select pub_id,avg(rating) avg_rating from ratings
group by pub_id;

-- 4. What are the top 5 beverages by sales quantity across all pubs?
select top 5 beverage_name, sum(quantity) total from sales s 
join beverages b on b.beverage_id=s.beverage_id
group by beverage_name
order by total desc;

-- 5. How many sales transactions occurred on each date?
select transaction_date, count(transaction_date) trans from sales
group by transaction_date;

-- 6. Find the name of someone that had cocktails and which pub they had it in.
select p.pub_name, customer_name, category from pubs p
join sales s on s.pub_id=p.pub_id
join beverages b on b.beverage_id=s.beverage_id
join ratings r on r.pub_id=p.pub_id
where category='Cocktail';

-- 7. What is the average price per unit for each category of beverages, excluding the category ‘Spirit’?
select category, avg(price_per_unit) as "average price per unit for each category of beverages"
from beverages
where not category = 'Spirit'
group by category;

-- 8. Which pubs have a rating higher than the average rating of all pubs?
select pub_name , avg(rating) avg_rating_higher from ratings r
join pubs p on p.pub_id=r.pub_id
group by pub_name
having avg(rating) >( select avg(rating) from ratings);

-- 9. What is the running total of sales amount for each pub, ordered by the transaction date?
select p.pub_id, p.pub_name, transaction_date, sum(price_per_unit*quantity) total_sales from pubs p
join sales s on s.pub_id=p.pub_id
join beverages b on b.beverage_id=s.beverage_id
group by p.pub_id, p.pub_name, transaction_date;

-- 10. For each country, what is the average price per unit of beverages in each category, and what is the overall average price per unit of beverages across all categories?
select country, category, round(avg(price_per_unit),1) avg_price, avg(round(avg(price_per_unit),1)) over (partition by category) avg_price_category from pubs p
join sales s on s.pub_id=p.pub_id
join beverages b on b.beverage_id=s.beverage_id
group by country, category;