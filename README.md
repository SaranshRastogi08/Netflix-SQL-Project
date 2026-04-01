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
- Source: Netflix dataset (CSV file)
- Contains details such as:
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

### 1. Content Distribution
- Counted total Movies vs TV Shows  

### 2. Most Common Ratings
- Found the most frequent rating for each content type  

### 3. Year-Based Filtering
- Retrieved movies released in a specific year  

### 4. Top Countries
- Identified top 5 countries with most content  

### 5. Longest Movie
- Found movie with maximum duration  

### 6. Recent Content
- Filtered content added in last 5 years  

### 7. Director Analysis
- Found content by specific director  

### 8. TV Shows with Multiple Seasons
- Identified shows with more than 5 seasons  

### 9. Genre Analysis
- Counted content per genre  

### 10. India Trends
- Analyzed yearly content release trends  

### 11. Documentaries
- Filtered documentary content  

### 12. Missing Data
- Found records without director  

### 13. Actor Analysis
- Checked movies featuring specific actors  

### 14. Top Actors
- Found actors with most appearances in Indian movies  

### 15. Content Categorization
- Classified content based on keywords  

---

## 📊 Key Learnings
- SQL querying and data analysis basics  
- Data cleaning using SQL functions  
- Use of aggregation and window functions  

---

## 🧠 Conclusion
This project helped build a strong foundation in SQL and data analysis by working on real-world data and solving practical problems.

---

## 👨‍💻 Author
Beginner data analyst passionate about learning SQL and data analytics.

---

## 🚀 Future Improvements
- Add data visualization tools  
- Perform advanced analysis  
- Improve data cleaning  
