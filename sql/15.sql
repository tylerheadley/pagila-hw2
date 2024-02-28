/*
 * Compute the total revenue for each film.
 */

SELECT title, COALESCE("sum", 0.00) as revenue
FROM (
    SELECT f.title, SUM(p.amount)
    FROM film f
    LEFT JOIN inventory i USING (film_id)
    LEFT JOIN rental r USING (inventory_id)
    LEFT JOIN payment p USING (rental_id)
    GROUP BY title
) subquery
ORDER BY revenue DESC;
