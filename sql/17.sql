/*
 * Compute the total revenue for each film.
 * The output should include another new column "total revenue" that shows the sum of all the revenue of all previous films.
 *
 * HINT:
 * My solution starts with the solution to problem 16 as a subquery.
 * Then I combine the SUM function with the OVER keyword to create a window function that computes the total.
 * You might find the following stackoverflow answer useful for figuring out the syntax:
 * <https://stackoverflow.com/a/5700744>.
 */


SELECT 
    "rank",
    title,
    revenue,
    SUM(revenue) OVER (
        ORDER BY revenue DESC
    ) AS "total revenue"
FROM (
    SELECT
        RANK () OVER (
           ORDER BY COALESCE("sum", 0.00) DESC
        ) "rank",
        title,
        COALESCE("sum", 0.00) as revenue
    FROM (
        SELECT f.title, SUM(p.amount)
        FROM film f
        LEFT JOIN inventory i USING (film_id)
        LEFT JOIN rental r USING (inventory_id)
        LEFT JOIN payment p USING (rental_id)
        GROUP BY title
    ) subquery1
) subquery2
ORDER BY revenue DESC, title;
