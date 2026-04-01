# 📊 Netflix Data Analysis (SQL Project)

## 📌 Project Overview
This project focuses on analyzing Netflix movies and TV shows data using SQL. The goal is to practice and demonstrate basic to intermediate SQL skills by solving real-world business questions using a structured dataset.

The project includes:
- A dataset in CSV format  
- SQL queries for analysis  
- Insights derived from the data  

---

## 🎯 Objectives
- Understand the distribution of Movies vs TV Shows  
- Explore ratings, genres, and release trends  
- Analyze country-wise content production  
- Practice SQL concepts like aggregation, filtering, window functions, and string operations  

---

## 📂 Dataset Information
The data for this project is sourced from the Kaggle dataset:

- **Dataset Link:** [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)
- **Contains details such as:**
  - Title  
  - Type (Movie / TV Show)  
  - Director & Cast  
  - Country  
  - Release Year  
  - Rating  
  - Duration  
  - Genre  
  - Description  

---

## 🗄️ Database Schema
The dataset is stored in a table named `netflix`.

```sql
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
    description VARCHAR(550)
);
```

---

## 🔍 Key Analysis Performed

### 1. Count the Number of Movies vs TV Shows

```sql
SELECT
type,
COUNT(*) AS Total_Content
FROM netflix
GROUP BY type;
```

**Objective:** Determine the distribution of content types on Netflix.

### 2. Find the Most Common Rating for Movies and TV Shows

```sql
SELECT
type,
rating
FROM
(SELECT type, rating, RANK() OVER (PARTITION BY type ORDER BY COUNT(*) DESC) AS rnk
 FROM netflix
 GROUP BY type, rating) t
WHERE rnk = 1;
```

**Objective:** Identify the most frequently occurring rating for each type of content.

### 3. List All Movies Released in a Specific Year (e.g., 2020)

```sql
SELECT *
FROM netflix
WHERE type = 'Movie' and release_year = 2020;
```

**Objective:** Retrieve all movies released in a specific year.

### 4. Find the Top 5 Countries with the Most Content on Netflix

```sql
SELECT
INITCAP(REGEXP_REPLACE(TRIM(UNNEST(STRING_TO_ARRAY(country, ','))), '\s+', ' ', 'g')) AS new_country,
COUNT(show_id) AS Total_Content
FROM netflix
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;
```

**Objective:** Identify the top 5 countries with the highest number of content items.

### 5. Identify the Longest Movie

```sql
SELECT 
title,
duration,
CAST(SPLIT_PART(duration, ' ', 1) AS INT) AS duration_minutes
FROM netflix
WHERE type = 'Movie' AND duration IS NOT NULL
ORDER BY duration_minutes DESC
LIMIT 1;
```

**Objective:** Find the movie with the longest duration.

### 6. Find Content Added in the Last 5 Years

```sql
SELECT 
title,
type,
date_added
FROM netflix
WHERE date_added IS NOT NULL AND TO_DATE(date_added, 'Month DD, YYYY') >= CURRENT_DATE - INTERVAL '5 years'
ORDER BY TO_DATE(date_added, 'Month DD, YYYY') DESC;
```

**Objective:** Retrieve content added to Netflix in the last 5 years.

### 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

```sql
SELECT *
FROM netflix
WHERE director ILIKE '%Rajiv Chilaka%';
```

**Objective:** List all content directed by 'Rajiv Chilaka'.

### 8. List All TV Shows with More Than 5 Seasons

```sql
SELECT *
FROM netflix
WHERE type = 'TV Show'
AND
SPLIT_PART(duration, ' ', 1)::INT > 5;
```

**Objective:** Identify TV shows with more than 5 seasons.

### 9. Count the Number of Content Items in Each Genre

```sql
SELECT
UNNEST(STRING_TO_ARRAY(listed_in, ',')) AS genre,
COUNT(show_id) AS total_content
FROM netflix
GROUP BY 1
ORDER BY total_content DESC, genre;
```

**Objective:** Count the number of content items in each genre.

### 10.Find each year and the average numbers of content release in India on netflix. 
return top 5 year with highest avg content release!

```sql
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
```

**Objective:** Calculate and rank years by the average number of content releases by India.

### 11. List All Movies that are Documentaries

```sql
SELECT *
FROM netflix
WHERE listed_in ILIKE '%documentar%';
```

**Objective:** Retrieve all movies classified as documentaries.

### 12. Find All Content Without a Director

```sql
SELECT *
FROM netflix
WHERE director IS NULL;
```

**Objective:** List content that does not have a director.

### 13. Find How Many Movies Actor 'Salman Khan' Appeared in the Last 10 Years

```sql
SELECT
*
FROM netflix
WHERE casts ILIKE '%Salman Khan%' AND type = 'Movie' AND release_year >= EXTRACT(YEAR FROM CURRENT_DATE) - 10;
```

**Objective:** Count the number of movies featuring 'Salman Khan' in the last 10 years.

### 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

```sql
SELECT
INITCAP(REGEXP_REPLACE(TRIM(UNNEST(STRING_TO_ARRAY(casts, ','))), '\s+', ' ', 'g')) AS actors,
COUNT(*) AS total_movies
FROM netflix
WHERE type ILIKE '%Movie%' AND country ILIKE '%india%'
GROUP BY 1
ORDER BY 2 DESC
LIMIT 10;
```

**Objective:** Identify the top 10 actors with the most appearances in Indian-produced movies.

### 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

```sql
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
``` 

---

## 📊 Key Learnings
- SQL querying and data analysis basics  
- Data cleaning using SQL functions  
- Use of aggregation and window functions  

---

## 🧠 Conclusion
- **Content Distribution:** The dataset includes a wide mix of movies and TV shows across different genres and categories.
- **Popular Ratings:** Analyzing the most frequent ratings helps in understanding the type of audience Netflix content is aimed at.
- **Regional Insights:** Examining top contributing countries and India’s yearly trends gives a clear picture of content distribution across regions.
- **Content Classification:** Grouping content based on keywords like violence or sensitive themes helps identify the overall nature of available content.

Overall, this analysis gives a clear overview of Netflix’s content library and helps in drawing useful insights for content planning and decision-making.
