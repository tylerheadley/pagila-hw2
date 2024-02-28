/*
 * Compute the total revenue for each film.
 * The output should include a new column "rank" that shows the numerical rank
 *
 * HINT:
 * You should use the `rank` window function to complete this task.
 * Window functions are conceptually simple,
 * but have an unfortunately clunky syntax.
 * You can find examples of how to use the `rank` function at
 * <https://www.postgresqltutorial.com/postgresql-window-function/postgresql-rank-function/>.
 */

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
) subquery
ORDER BY revenue DESC;

