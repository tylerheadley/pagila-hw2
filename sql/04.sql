/*
 * Select the titles of all films that the customer with customer_id=1 has rented more than 1 time.
 *
 * HINT:
 * It's possible to solve this problem both with and without subqueries.
 */

SELECT f.title 
FROM film f
JOIN inventory i USING (film_id)
JOIN rental r USING (inventory_id)
JOIN customer c USING (customer_id) 
WHERE c.customer_id = 1
GROUP BY f.title
HAVING COUNT(*) > 1;
