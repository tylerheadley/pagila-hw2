/*
 * This problem is the same as 07.sql,
 * but instead of using the NOT IN operator, you are to use a LEFT JOIN.
 */

SELECT DISTINCT f.title
FROM film f
JOIN inventory i USING (film_id)
LEFT JOIN (
    SELECT i.film_id
    FROM inventory i
    JOIN rental USING (inventory_id)
    JOIN customer USING (customer_id)
    JOIN address USING (address_id)
    JOIN city USING (city_id)
    JOIN country c USING (country_id)
    WHERE c.country_id = 103
) excluded_films ON f.film_id = excluded_films.film_id
WHERE excluded_films.film_id IS NULL
ORDER BY f.title;
