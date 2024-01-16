-- 1. List each pair of actors that have worked together.

SELECT DISTINCT fa1.actor_id, a1.first_name, a1.last_name, fa2.actor_id, a2.first_name, a2.last_name
FROM film_actor fa1
JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
JOIN actor a1 ON fa1.actor_id = a1.actor_id
JOIN actor a2 ON fa2.actor_id = a2.actor_id
WHERE fa1.actor_id <> fa2.actor_id;

-- 2. For each film, list actor that has acted in more films.

SELECT f.film_id, f.title, a.actor_id, a.first_name, a.last_name
FROM film f
JOIN film_actor fa ON fa.film_id = f.film_id
JOIN actor a ON a.actor_id = fa.actor_id
JOIN (
    SELECT fa.actor_id, COUNT(*) AS film_count
    FROM film_actor fa
    GROUP BY fa.actor_id
) subquery ON subquery.actor_id = fa.actor_id
JOIN (
    SELECT fa.film_id, MAX(subquery.film_count) AS max_film_count
    FROM film_actor fa
    JOIN (
        SELECT fa.actor_id, COUNT(*) AS film_count
        FROM film_actor fa
        GROUP BY fa.actor_id
    ) subquery ON subquery.actor_id = fa.actor_id
    GROUP BY fa.film_id
) subquery2 ON subquery2.film_id = f.film_id AND subquery.film_count = subquery2.max_film_count;