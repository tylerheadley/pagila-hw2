/*
 * List the title of all movies that have both the 'Behind the Scenes' and the 'Trailers' special_feature
 *
 * HINT:
 * Create a select statement that lists the titles of all tables with the 'Behind the Scenes' special_feature.
 * Create a select statement that lists the titles of all tables with the 'Trailers' special_feature.
 * Inner join the queries above.
 */

SELECT title
FROM (
    SELECT title
    FROM film
    WHERE 'Behind the Scenes' IN (
       SELECT unnest(special_features)
       FROM film f
       WHERE f.film_id = film.film_id
    )
) AS movies_with_behind_the_scenes
JOIN (
    SELECT title
    FROM film
    WHERE 'Trailers' IN (
       SELECT unnest(special_features)
       FROM film f
       WHERE f.film_id = film.film_id
    )
) AS movies_with_trailers USING (title)
ORDER BY title;
