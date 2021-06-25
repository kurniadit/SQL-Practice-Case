
/*A customer wants to know the films about “astronauts”. How many recommendations could you give for him?*/
select count(film_id)
from film
where array_to_string(tsvector_to_array(fulltext ::tsvector),',') like '%astronaut%';

/*I wonder, how many films have a rating of “R” and a replacement cost between $5 and $15?*/
select count(film_id) 
from film
where rating = 'R' and replacement_cost between 5 and 15;

/*How many payments did each staff member handle? 
 *And how much was the total amount processed by each staff member?*/
select staff_id,count(payment_id) as number_of_payment,sum(amount) as amount 
from payment
group by staff_id ;

/*-	Corporate headquarters is auditing the store!
 * They want to know the average replacement cost of movies by rating!*/
select rating , avg(replacement_cost) 
from film
group by rating;

/*We want to send coupons to the 5 customers who have spent the most amount of money.
 *Get the customer name, email and their spent amount!*/
select first_name ,last_name ,email ,sum(amount) as spend_amount
from customer 
full outer join payment 
on customer.customer_id = payment.customer_id 
group by first_name ,last_name ,email
order by spend_amount desc
limit 5;

/* We want to audit our stock of films in all of our stores. 
 * How many copies of each movie in each store, do we have?*/
select  film_id,store_id, count(film_id) as copies_of_movie
from inventory 
group by film_id,store_id ;

/*-	We want to know what customers are eligible for our platinum credit card.
 *The requirements are that the customer has at least a total of 40 transaction payments.
 *Get the customer name, email who are eligible for the credit card!*/ 
select first_name,last_name,email, count(payment_id) as count_payment
from payment inner join customer
on payment.customer_id=customer.customer_id
group by first_name,last_name,email,payment.customer_id
having count(payment_id)>40;


