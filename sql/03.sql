/*
 * Management wants to send coupons to customers who have previously rented one of the top-5 most profitable movies.
 * Your task is to list these customers.
 *
 * HINT:
 * In problem 16 of pagila-hw1, you ordered the films by most profitable.
 * Modify this query so that it returns only the film_id of the top 5 most profitable films.
 * This will be your subquery.
 * 
 * Next, join the film, inventory, rental, and customer tables.
 * Use a where clause to restrict results to the subquery.
 */

WITH TopMovies AS (
    SELECT
        f.title,
        SUM(p.amount) as profit
    FROM
        film f
    INNER JOIN
        inventory i ON f.film_id = i.film_id
    INNER JOIN
        rental r ON r.inventory_id = i.inventory_id
    INNER JOIN
        payment p ON p.rental_id = r.rental_id
    GROUP BY
        f.title
    ORDER BY
       profit DESC
    LIMIT 5
) 

SELECT DISTINCT customer_id
FROM customer c
JOIN rental r USING (customer_id)
JOIN inventory i USING (inventory_id)
JOIN film f USING (film_id)
WHERE f.title IN (
    SELECT title
    FROM TopMovies
)
ORDER BY customer_id;
