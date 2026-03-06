-- Using Database
use zepto1_db;

-- Q1 Create table

create table zepto(
category varchar(100),
name varchar(100) NOT NULL,
mrp int,
discountPercent decimal(10,2),
availableQuantity int,
discountedSellingPrice decimal(10,2),
weightInGms int,
outOfStock tinyint(1),
quantity int
);

ALTER TABLE zepto
ADD id int auto_increment PRIMARY KEY;


-- Q2. Describe Table 

desc zepto;


-- Data Exploration
select * from zepto;


-- Q3. Count of records
-- A3. No Null values

SELECT count(*)
FROM zepto;


-- Sample Data

select * From zepto
limit 10;


-- null values

select * From zepto
where name IS NULL
OR
category IS NULL
OR
mrp IS NULL
OR
discountPercent IS NULL
OR
availableQuantity IS NULL
OR
weightInGms IS NULL
OR
outOfStock IS NULL
OR
quantity IS NULL;

-- Q4 Different type of category

Select Distinct category
From zepto
order by category;


-- Q5 find how many product are in stock and out of stock
-- A5 3275 product are in stock and 453 products are in outOfStock

Select outOfStock, count(id)
from zepto
group by outOfStock;


-- Q6 products name in multiple times

select name , count(id)
from zepto
group by name
having count(id)>1
order by count(id) desc;


-- Q7 Find highest stock by category wise
-- A7 cooking essentials and munchies are in high in stock

select category ,count(id)
from zepto
where outOfStock = 'FALSE'
group by category
having count(id)>1
order by count(id) desc;

-- data cleaning

-- Q8 Find Products price == 0

select *
from zepto
where mrp = 0 or discountedSellingPrice = 0;

-- Delete 0 price product

set sql_safe_updates= 0;
Delete From zepto
where mrp = 0;



-- Q9 convert paise to rupees

update zepto
set mrp = mrp/100.0,
discountedSellingPrice = discountedSellingPrice/100.0;



-- Q10. Find top 10 best value products based on discount percentage?

select name,max(discountPercent) as max_discount_product
from zepto
group by name
order by max_discount_product desc
limit 10;


-- Q11. What are the products have high mrp but out of stock

Select name, max(mrp) as high_mrp , count(id)
from zepto
where outOfStock = 'TRUE' and mrp > 300.00
group by name
order by high_mrp desc
limit 10;


-- Q12 Calculate estimated revenue for each category

select category,
sum(discountedSellingPrice * availableQuantity) as TotalRevenue
from zepto
group by category
order by TotalRevenue desc;


-- Q13. Find all products where MRP is greater than rs.500 and discount is less than 10%

Select distinct name , mrp, discountPercent
from zepto
where mrp > 500 and discountPercent < 10.00
order by mrp asc, discountPercent asc;

-- Q14. Find the top 5 category offering the highest average discount percentage

select category,
round(avg(discountPercent),2) as average_discountPercent
from zepto
group by category
order by average_discountPercent desc
limit 5;


-- Q15. Find the price per gram for the products above 100g and sort by best value.

Select name,discountedSellingPrice,weightInGms,
round((discountedSellingPrice/weightInGms),2)as price_per_gms
from zepto
where weightInGms > 100
order by price_per_gms;


-- Q16. Group the products into category like low,medium,bulk.alter

select category , weightInGms,
CASE
	when weightInGms < 1000 THEN 'LOW'
    when weightInGms <5000 THEN 'MEDIUM'
    ELSE 'BULK'
END AS Weight_category
from zepto;


-- Q17. what is the total inventory weight per product

select name ,
sum(weightInGms * availableQuantity) as Total_weight
from zepto
group by name
order by Total_weight desc;


    








--










