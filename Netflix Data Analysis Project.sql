-- Netflix Project

CREATE TABLE netflix(
show_id VARCHAR(5),
type VARCHAR(10),
title VARCHAR(250),
director VARCHAR(550),
casts VARCHAR(1050),
country VARCHAR(550),
date_added VARCHAR(55),
release_year INT,
rating VARCHAR(15),
duration VARCHAR(15),
listed_in VARCHAR(250),
description VARCHAR(550));

SELECT * FROM netflix;

SELECT COUNT(*) total_count
FROM netflix;

SELECT DISTINCT type
FROM netflix;

-- 1. Count the number of Movies vs TV Shows.

SELECT
type,
COUNT(*) AS Total_Content
FROM netflix
GROUP BY type;

-- 2. Find the most common rating for movies and TV shows.

SELECT
type,
rating
FROM
(SELECT type, rating, RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
 FROM netflix
 GROUP BY type, rating) t
WHERE rnk = 1;

-- 3. List all movies released in a specific year.

SELECT *
FROM netflix
WHERE type = 'Movie' and release_year = 2020;

-- 4. Find the top 5 countries with the most content on Netflix.

SELECT
INITCAP(REGEXP_REPLACE(TRIM(UNNEST(STRING_TO_ARRAY(country, ','))), '\s+', ' ', 'g')) AS new_country,
COUNT(show_id) AS Total_Content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- 5. Identify the longest movie.

SELECT 
title,
duration,
CAST(SPLIT_PART(duration, ' ', 1) AS INT) AS duration_minutes
FROM netflix
WHERE type = 'Movie' AND duration IS NOT NULL
ORDER BY duration_minutes DESC
LIMIT 1;

-- 6. Find content added in the last 5 years.

SELECT 
title,
type,
date_added
FROM netflix
WHERE date_added IS NOT NULL AND TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
ORDER BY TO_DATE(date_added, 'Month DD, YYYY') DESC;

-- 7. Find all the movies/TV shows by director 'Rajiv Chilaka'.

SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';

-- 8. List all TV shows with more than 5 seasons.

SELECT *
FROM netflix
WHERE type = 'TV Show'
AND
SPLIT_PART(duration, ' ', 1)::INT > 5;

-- 9. Count the number of content items in each genre.

SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY total_content DESC, genre;

-- 10. Find each year and the average numbers of content release by India on netflix and return top 5 year with highest avg content release.

SELECT
    year,
    yearly_content,
    ROUND(AVG(yearly_content) OVER (), 2) AS avg_content
FROM (
    SELECT
        EXTRACT(YEAR FROM TO_DATE(date_added, 'Month DD, YYYY')) AS year,
        COUNT(*) AS yearly_content
    FROM netflix
    WHERE country ILIKE '%India%'
      AND date_added IS NOT NULL
    GROUP BY 1
) sub
ORDER BY yearly_content DESC
LIMIT 5;

-- 11. List all movies that are documentaries.

SELECT *
FROM netflix
WHERE listed_in ILIKE '%documentar%';

-- 12. Find all content without a director.

SELECT *
FROM netflix
WHERE director IS NULL;

-- 13. Find how many movies actor 'Salman Khan' appeared in last 10 years.

SELECT
*
FROM netflix
WHERE casts ILIKE '%Salman Khan%' AND type = 'Movie' AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;

-- 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

SELECT
INITCAP(REGEXP_REPLACE(TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))), '\s+', ' ', 'g')) AS actors,
COUNT(*) AS total_movies
FROM netflix
WHERE type ILIKE '%Movie%' AND country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;

--15. Categorize the content based on the presence of the keywords 'kill' and 'violence' in the description field. Label content containing these keywords as 'Bad' and all other content as 'Good'. Count how many items fall into each category.

WITH new_table
AS
(SELECT *,
CASE
WHEN
description ILIKE '%kill%' OR description ILIKE '%violence%'
THEN 'Bad Content'
ELSE 'Good Content'
END category
FROM netflix)
SELECT
category,
COUNT(*) AS total_content
FROM new_table
GROUP BY 1;