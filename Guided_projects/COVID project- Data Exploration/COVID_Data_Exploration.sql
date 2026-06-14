USE sample_sql_project;

SELECT *
FROM Covid_deaths
ORDER BY 3,4;

SELECT *
FROM Covid_vaccinations
ORDER BY 3,4;

SELECT
	location,
	date,
	total_cases,
	new_cases,
	total_deaths,
	population
FROM Covid_deaths
WHERE continent IS NOT NULL
ORDER BY 
	location,
	date;

-- Looking at Total Cases vs Total Deaths
-- Shows likelihood of dying if you contract covid in your country

SELECT
	location,
	date,
	total_cases,
	total_deaths,
	(total_deaths / total_cases)*100 AS death_percentage
FROM Covid_deaths
WHERE location LIKE '%INDIA%'
	AND continent IS NOT NULL
ORDER BY 
	location,
	date;


-- Looking at the Total Cases vs the Population
-- Shows what percentage of population got Covid

SELECT
	location,
	date,
	population,
	total_cases,
	(total_cases / population)*100 AS percent_population_infected
FROM Covid_deaths
WHERE location LIKE '%INDIA%'
	AND continent IS NOT NULL
ORDER BY 
	location,
	date;



-- Looking at Countries with Highest Infection Rate compared to Population

SELECT
	location,
	population,
	MAX(total_cases) AS highest_infection_count,
	MAX((total_cases / population))*100 AS percent_population_infected
FROM Covid_deaths
GROUP BY
	location,
	population
ORDER BY percent_population_infected DESC;



-- Showing Countries with Highest Death count per population

SELECT
	location,
	MAX(CAST(total_deaths AS INT)) AS Total_Death_count
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY Total_Death_count DESC



-- Showing continents with the highest death count per population

SELECT
	continent,
	MAX(CAST(total_deaths AS INT)) AS Total_Death_count
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY Total_Death_count DESC

-- GLOBAL NUMBERS

SELECT
	date,
	SUM(new_cases) AS total_cases,
	SUM(CAST(new_deaths AS INT)) AS total_deaths,
	(SUM(CAST(new_deaths AS INT)) / SUM(new_cases))*100 AS death_percentage
FROM Covid_deaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY date;


SELECT
	SUM(new_cases) AS total_cases,
	SUM(CAST(new_deaths AS INT)) AS total_deaths,
	(SUM(CAST(new_deaths AS INT)) / SUM(new_cases))*100 AS death_percentage
FROM Covid_deaths
WHERE continent IS NOT NULL;



-- Looking at Total Population vs Vaccinations

-- CTE

WITH PopvsVac AS
(
	SELECT
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cv.new_vaccinations,
	SUM(CAST(cv.new_vaccinations AS INT)) OVER (
		PARTITION BY 
			cd.location
		ORDER BY
			cd.location,
			cd.date
		) AS rolling_people_vaccinated
	FROM Covid_deaths AS cd
	INNER JOIN Covid_vaccinations AS cv
	ON cd.location = cv.location
		AND cd.date = cv.date
	WHERE cd.continent IS NOT NULL
)
SELECT *,
	(rolling_people_vaccinated/population)*100
FROM PopvsVac;



-- temp table

DROP TABLE IF EXISTS #PercentPopulationVaccinated
CREATE TABLE #PercentPopulationVaccinated
(
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATETIME,
Population NUMERIC,
New_vaccinations NUMERIC,
rolling_people_vaccinated NUMERIC
)

INSERT INTO #PercentPopulationVaccinated
SELECT
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cv.new_vaccinations,
	SUM(CAST(cv.new_vaccinations AS INT)) OVER (
		PARTITION BY 
			cd.location
		ORDER BY
			cd.location,
			cd.date
		) AS rolling_people_vaccinated
FROM Covid_deaths AS cd
INNER JOIN Covid_vaccinations AS cv
ON cd.location = cv.location
	AND cd.date = cv.date

SELECT *,
	(rolling_people_vaccinated/population)*100
FROM #PercentPopulationVaccinated;



-- Creating View to store data for later visualizations

CREATE VIEW PercentPopulationVaccinated AS
SELECT
	cd.continent,
	cd.location,
	cd.date,
	cd.population,
	cv.new_vaccinations,
	SUM(CAST(cv.new_vaccinations AS INT)) OVER (
		PARTITION BY 
			cd.location
		ORDER BY
			cd.location,
			cd.date
		) AS rolling_people_vaccinated
FROM Covid_deaths AS cd
INNER JOIN Covid_vaccinations AS cv
ON cd.location = cv.location
	AND cd.date = cv.date
WHERE cd.continent IS NOT NULL;

SELECT *
FROM PercentPopulationVaccinated