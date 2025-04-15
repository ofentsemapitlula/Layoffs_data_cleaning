-- DATA Cleaning

SELECT *
FROM layoffs;

-- Create a working sheet to avoid doing changes on the raw data
CREATE TABLE layoffs_workingsheet
LIKE layoffs;
INSERT INTO layoffs_workingsheet
SELECT *
FROM layoffs;

SELECT *
FROM layoffs_workingsheet;

-- Create cte to check for duplicates
WITH duplicate_cte AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_workingsheet
)
SELECT *
FROM duplicate_cte
WHERE row_num > 1;

-- Create table workingsheet2 with additional column row_num
CREATE TABLE `layoffs_workingsheet2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- Test if table was created as expected
SELECT *
FROM layoffs_workingsheet2;

-- Insert data into the new table
INSERT INTO layoffs_workingsheet2
SELECT *,
ROW_NUMBER() OVER(PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, `date`, stage, country, funds_raised_millions) AS row_num
FROM layoffs_workingsheet;

-- Show duplicates 
SELECT *
FROM layoffs_workingsheet2
WHERE row_num > 1;

-- Delete duplicates
DELETE 
FROM layoffs_workingsheet2
WHERE row_num > 1;

-- Check if the duplicates are removed
SELECT *
FROM layoffs_workingsheet2
WHERE row_num > 1;

