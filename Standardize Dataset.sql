-- Standardize data

SELECT company, TRIM(company) 
FROM layoffs_workingsheet2;

-- Removing white spaces
UPDATE layoffs_workingsheet2
SET company = TRIM(company);

SELECT DISTINCT industry
FROM layoffs_workingsheet2
ORDER BY industry;

SELECT *
FROM layoffs_workingsheet2
WHERE industry LIKE 'Crypto%';

UPDATE layoffs_workingsheet2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT country
FROM layoffs_workingsheet2
ORDER BY country ;

UPDATE layoffs_workingsheet2
SET country = 'United States'
WHERE country LIKE 'United States%';

SELECT DISTINCT country
FROM layoffs_workingsheet2
ORDER BY country DESC;

SELECT `date`, 
STR_TO_DATE(`date`, '%m/%d/%Y') AS updated_date
FROM layoffs_workingsheet2;

UPDATE layoffs_workingsheet2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

SELECT `date`
FROM layoffs_workingsheet2;

ALTER TABLE layoffs_workingsheet2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_workingsheet2
WHERE industry IS NULL
OR industry = '';

UPDATE layoffs_workingsheet2
SET industry = null
WHERE industry = '';

SELECT t1.industry, t2.industry
FROM layoffs_workingsheet2 t1
JOIN layoffs_workingsheet2 t2
	ON t1.company = t2.company
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

UPDATE layoffs_workingsheet2 t1
JOIN layoffs_workingsheet2 t2
	ON t1.company = t2.company
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT *
FROM layoffs_workingsheet2
WHERE industry is NULL;

ALTER TABLE layoffs_workingsheet2
DROP COLUMN row_num;










