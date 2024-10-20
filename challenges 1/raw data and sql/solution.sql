select * from [dbo].[sales];
select * from [dbo].[cars];
select * from [dbo].[salespersons];
--1. What are the details of all cars purchased in the year 2022?
select * from cars c
join sales s on c.car_id=s.car_id
where year(purchase_date)=2022
order by c.car_id asc;
-- 2. What is the total number of cars sold by each salesperson?
select sales.salesman_id, salespersons.name ,count(car_id) car_amount from sales
join salespersons on sales.salesman_id= salespersons.salesman_id
group by sales.salesman_id, salespersons.name
order by car_amount desc;
-- 3. What is the total revenue generated by each salesperson?
select s.salesman_id, name,sum(cost_$) revenue from sales s
join cars c on s.car_id=c.car_id
join salespersons on s.salesman_id= salespersons.salesman_id
group by s.salesman_id, name
order by revenue desc;
-- 4. What are the details of the cars sold by each salesperson?
select s.salesman_id, name, c.car_id, make, type, style, cost_$ from [dbo].[salespersons] sp
join [dbo].[sales] s on s.salesman_id=sp.salesman_id
join [dbo].[cars] c on c.car_id= s.car_id

-- 5. What is the total revenue generated by each car type?
select c.type,sum(cost_$) revenue from sales s
join cars c on s.car_id=c.car_id
group by c.type
order by revenue desc;

--6. What are the details of the cars sold in the year 2021 by salesperson �Emily Wong�?
select s.salesman_id, sp.name, c.car_id, make, type, style, cost_$ from [dbo].[salespersons] sp
join [dbo].[sales] s on s.salesman_id=sp.salesman_id
join [dbo].[cars] c on c.car_id= s.car_id
where sp.name ='Emily Wong' and year(purchase_date)=2021;

-- 7. What is the total revenue generated by the sales of hatchback cars?
select c.car_id, sum(cost_$) revenue from [dbo].[sales] s
join [dbo].[cars] c
on s.car_id=c.car_id
where style='Hatchback'
group by c.car_id;

-- 8. What is the total revenue generated by the sales of SUV cars in the year 2022?
select c.style, sum(cost_$) revenue from [dbo].[sales] s
join [dbo].[cars] c
on s.car_id=c.car_id
where style='SUV' and year(purchase_date)=2022
group by c.style

-- 9. What is the name and city of the salesperson who sold the most number of cars in the year 2023?
select top 1 name, city,count(s.car_id) amount from salespersons sp
join sales s on s.salesman_id=sp.salesman_id
where year(purchase_date)=2023
group by name, city
order by amount desc

-- 10. What is the name and age of the salesperson who generated the highest revenue in the year 2022?
select top 1 name, age,sum(cost_$) revenue from salespersons sp
join sales s on s.salesman_id=sp.salesman_id
join cars c on c.car_id=s.car_id
where year(purchase_date)=2022
group by name, age
order by revenue desc

