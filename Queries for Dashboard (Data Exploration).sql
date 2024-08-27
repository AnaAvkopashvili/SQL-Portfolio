/*

Queries used for Tableau Project

*/



-- 1.
-- (number of people affected in the world)


Select SUM(new_cases) as total_cases, SUM(new_deaths) as total_deaths, SUM(new_deaths)/SUM(new_cases) * 100 as DeathPercentage
From PortfolioProject..CovidDeathsCSV
--Where location like '%states%'
where continent is not null 
--Group By date
order by 1,2

-- Just a double check based off the data provided
-- numbers are extremely close so we will keep them - The Second includes "International"  Location

--Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(New_Cases)*100 as DeathPercentage
--From PortfolioProject..CovidDeathsCSV
----Where location like '%states%'
--where location = 'World'
----Group By date
--order by 1,2



-- 2. 
--(continent death count)

-- We take these out as they are not inluded in the above queries and want to stay consistent
-- European Union is part of Europe

Select location, SUM(new_deaths) as TotalDeathCount
From PortfolioProject..CovidDeathsCSV
--Where location like '%states%'
Where continent is null 
and location not in ('World', 'European Union', 'International')
Group by location
order by TotalDeathCount desc



-- 3.
--( countries with highest infection rate with percentage of the population affected)

Select Location, Population, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeathsCSV
--Where location like '%states%'
Group by Location, Population
order by PercentPopulationInfected desc



-- 4.

Select Location, Population, date, MAX(total_cases) as HighestInfectionCount,  Max((total_cases/population))*100 as PercentPopulationInfected
From PortfolioProject..CovidDeathsCSV
--Where location like '%states%'
Group by Location, Population, date
order by PercentPopulationInfected desc












/*

DATA EXPLORATION

*/




-- Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

SELECT * 
FROM PortfolioProject..CovidDeathsCSV
WHERE continent is not null
order by 3,4;

-- select data that we are going to be using

SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeathsCSV
order by 1,2;


-- total cases  vs total deaths
-- shows the likelihood of dying  if you contract covid in Georgia

SELECT Location, date, total_cases, total_deaths,
	(total_deaths / total_cases) * 100 as death_percentage
FROM PortfolioProject..CovidDeathsCSV
where location = 'Georgia'
order by 1,2;


-- total cases vs population
-- shows what percentage of population got Covid 

SELECT Location, date, total_cases, population,
	(total_cases / population) * 100 as case_percentage_by_population
FROM PortfolioProject..CovidDeathsCSV
--where location = 'Georgia'
order by 1,2;


-- countries with highest death count

SELECT Location, MAX(total_deaths) as total_death_count
FROM PortfolioProject..CovidDeathsCSV
where continent is not null
group by Location
order by total_death_count desc;



-- GLOBAL NUMBERS	
-- number of people affected in the world by dates

SELECT date, sum(new_cases) as summed_cases, sum(new_deaths) as summed_deaths,
	(sum(new_deaths) / sum(new_cases)) * 100 as death_percentage
FROM PortfolioProject..CovidDeathsCSV
where continent is not null
group by date
order by 1;


-- join COVID VACCINATIONS

select *
from PortfolioProject..CovidDeathsCSV as dea
join PortfolioProject..CovidVaccinationsCSV as vac
	on dea.location = vac.location
	and dea.date = vac.date;


-- runing total vaccinations
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	 sum(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date)
	 AS running_total_vaccinations
from PortfolioProject..CovidDeathsCSV as dea
join PortfolioProject..CovidVaccinationsCSV as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2,3;


-- runing total vaccinations vs population 
-- (CTE)

with vacination_data as 
(
	select dea.continent as continent,
		dea.location as location,
		dea.date as date,
		dea.population as population,
		vac.new_vaccinations as new_vacs,
		sum(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date)
		 AS running_total_vaccinations
	from PortfolioProject..CovidDeathsCSV as dea
	join PortfolioProject..CovidVaccinationsCSV as vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent is not null
)
select	
	*,
	(running_total_vaccinations / population) * 100 as population_vaccinated_percentage
from vacination_data
order by location, date;

-- (TEMP TABLE)

drop table if exists #PopulationVaccinatedPercentage
create table #PopulationVaccinatedPercentage
(
	continent nvarchar(255),
	location nvarchar(255),
	date datetime,
	population numeric,
	new_vaccinations numeric,
	running_total_vaccinations numeric
)
insert into #PopulationVaccinatedPercentage

select dea.continent as continent,
		dea.location as location,
		dea.date as date,
		dea.population as population,
		vac.new_vaccinations as new_vacs,
		sum(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date)
		 AS running_total_vaccinations
	from PortfolioProject..CovidDeathsCSV as dea
	join PortfolioProject..CovidVaccinationsCSV as vac
		on dea.location = vac.location
		and dea.date = vac.date
	where dea.continent is not null

select	
	*,
	(running_total_vaccinations / population) * 100 as population_vaccinated_percentage
from #PopulationVaccinatedPercentage
order by location, date; 


-- creating view to store data for later visualizations

/*
CREATE VIEW	RunningTotalVaccinations as
select dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
	 sum(vac.new_vaccinations) OVER (partition by dea.location order by dea.location, dea.date)
	 AS running_total_vaccinations
from PortfolioProject..CovidDeathsCSV as dea
join PortfolioProject..CovidVaccinationsCSV as vac
	on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
*/

select * from RunningTotalVaccinations