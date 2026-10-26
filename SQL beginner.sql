Select *
FROM rental;

select first_name,last_name,email
From customer;
select distinct rating 
from film;

 select distinct rental_duration
 from film;
 
select customer_id,rental_id,amount,payment_date
from payment
where customer_id<101;

select customer_id, rental_id,amount,payment_date
from payment
where amount=0.99  AND payment_date > '2006-01-01';

select customer_id, rental_id,amount,payment_date
from payment
where customer_id<101 and  amount>5 AND  payment_date > '2006-01-01';

select customer_id, rental_id,amount,payment_date
from payment
where amount>5 OR customer_id IN(42,53,60,75);

select title , description
FROM film
where description LIKE '%China' ;

select title ,special_features
from film 
where special_features LIKE '%Behind the Scenes%';

-- large comments are denoted by this sign /* */
/*
select first_name,last_name,email
From customer;
select distinct rating 
from film;
*/
select rental_duration,
count(film_id) AS films_with_this_rental_duration 
FROM film  
group by rental_duration;

select replacement_cost, count(film_id) as number_of_films,
min(film_id) as cheapest_rental,
max(film_id) as most_expensive_rental,
 avg(film_id) as average_rental
from film
group by replacement_cost;

select customer_id,
count(rental_id) as total_rental
from rental
group by customer_id
Having COUNT(rental_id) <15;

select title,rental_rate,length
from film
order by length DESC;

/* select
FROM
WHERE
GROUP BY
HAVING
ORDER BY 
*/

select distinct
length,
CASE
WHEN length< 60 THEN 'under 1 hour'
WHEN length< 90 THEN 'BETWEEN 1-1.5 hour'
WHEN length> 120 THEN 'over 2 hours'
ELSE 'uh oh...check logic'
END AS length_bucket 
FROM film;

select first_name, last_name,
CASE 
WHEN store_id=1 AND active>0  THEN 'store 1 active' 
WHEN store_id=1 AND active=0  THEN 'store 1 inactive' 
WHEN store_id=2 AND active>0  THEN 'store 2 active' 
WHEN store_id=2 AND active=0  THEN 'store 2 inactive'
ELSE 'don t know' 
END As store_and_status
FROM customer;

-- mid course project
select first_name,last_name,email,store_id
from staff;

select store_id,
COUNT(inventory_id) AS inventory_items
from inventory
group by store_id;

select store_id,
count(customer_id) as active_customers
from customer
where active=1
group by store_id;

select 
COUNT(email) as emails
from customer ;

-- Union und Joins
-- find the common coulmn
select inventory_id, store_id
FROM inventory 
INNER JOIN film
ON inventory.film_id = film.film_id;

-- in inner join we get data only when we have a match, but in left join we don't loose...
-- any data , it returns us matches and if there is no match then also we don't loose any data from the left table.

select distinct inventory.inventory_id, rental.inventory_id
FROM inventory 
inner JOIN rental
ON inventory.inventory_id=rental.inventory_id;

select distinct inventory.inventory_id, rental.inventory_id
FROM inventory 
left JOIN rental
ON inventory.inventory_id=rental.inventory_id;

select film.title,
COUNT(film_actor.actor_id) as count_of_actors
from film
LEFT JOIN film_actor
ON  film_actor.film_id=film.film_id
GROUP BY  film.title;

-- bridging
select  actor.first_name, actor.last_name, film.title
from actor
INNER JOIN film_actor
On actor.actor_id=film_actor.actor_id
INNER JOIN film
ON film.film_id=film_actor.film_id;

 -- UNION
 select 'advisor' as type,
 first_name ,last_name 
 From advisor
 
UNION
SELECT 'staff' as type
 ,first_name,last_name 
 From 
 staff;
 
 