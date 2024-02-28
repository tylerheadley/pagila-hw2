/*
 * Management is planning on purchasing new inventory.
 * Films with special features cost more to purchase than films without special features,
 * and so management wants to know if the addition of special features impacts revenue from movies.
 *
 * Write a query that for each special_feature, calculates the total profit of all movies rented with that special feature.
 *
 * HINT:
 * Start with the query you created in pagila-hw1 problem 16, but add the special_features column to the output.
 * Use this query as a subquery in a select statement similar to answer to the previous problem.
 */

SELECT unnest(special_features) AS special_feature, sum(profit) AS profit
FROM (
    SELECT
        f.title,
        SUM(p.amount) as profit,
        special_features
    FROM
        film f
    INNER JOIN
        inventory i ON f.film_id = i.film_id
    INNER JOIN
        rental r ON r.inventory_id = i.inventory_id
    INNER JOIN
        payment p ON p.rental_id = r.rental_id
    GROUP BY
        f.title,
        special_features
    ORDER BY
        profit DESC
) AS movie_profits
GROUP BY unnest(special_features)
ORDER BY special_feature;
