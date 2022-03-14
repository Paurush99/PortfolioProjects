SELECT *
FROM PortfolioProjects..CovidDeaths$
order by 3,4

--SELECT *
--FROM PortfolioProjects..CovidVaccinations$
--order by 3,4

--select data that to be used
SELECT location, date, total_cases, new_cases, total_deaths,  population
FROM PortfolioProjects..CovidDeaths$
order by 1,2

-- Looking at total cases vs total deaths
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjects..CovidDeaths$
order by 1,2

-- India
--Shows the likelihood  of dying if you contract Covid in India
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProjects..CovidDeaths$
where  location like '%india%'
order by 1,2

--Looking at the total cases  vs the population
SELECT location, date, total_cases, population, (total_cases/population)*100 as CovidAffected
FROM PortfolioProjects..CovidDeaths$
where  location like '%india%'
order by 1,2

--world
SELECT location, date, total_cases, population, (total_cases/population)*100 as CovidAffected
FROM PortfolioProjects..CovidDeaths$
--where  location like '%india%'
order by 1,2

--Looking at countries with highest infection rate

SELECT location, population, MAX(total_cases) as HighestInfectionCount,  (MAX(total_cases)/population)*100 as CovidAffected
FROM PortfolioProjects..CovidDeaths$
--where  location like '%india%'
group by location, population
order by CovidAffected desc

--Countries with High Death Percent count per population
SELECT location, population, MAX(cast(total_deaths as int)) as HighestDeathCount, (MAX(cast(total_deaths as int))/population)*100 as DeathPercent
FROM PortfolioProjects..CovidDeaths$
where continent is not NULL
group by location, population
order by DeathPercent desc

--Continents with High Death count

SELECT location, population, MAX(cast(total_deaths as int)) as HighestDeathCount, (MAX(cast(total_deaths as int))/population)*100 as DeathPercent
FROM PortfolioProjects..CovidDeaths$
where continent is NULL
group by location, population
order by HighestDeathCount desc

--GLOBAL No.s
SELECT date, SUM(new_cases), SUM(cast(new_deaths as int)), (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as FatalityPercent
From PortfolioProjects..CovidDeaths$
where continent is not null
group by date
order by 1,2

--Final numbers
SELECT SUM(new_cases), SUM(cast(new_deaths as int)), (SUM(cast(new_deaths as int))/SUM(new_cases))*100 as FatalityPercent
From PortfolioProjects..CovidDeaths$
where continent is not null
order by 1,2

--Covidvaccinations table
Select *
from PortfolioProjects..CovidVaccinations$

--Join CovidDeaths and Covidvaccinations
Select *
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date

--Looking at Total Population vs Vaccinations
Select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by vac.location, dea.date) as  RollingPeopleVacc
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
order by 2,3


--USE CTE

With PopVsVac (Continent,Loaction, Date, Population, NewVacc, RollingPeopleVaccinated)
as (
Select dea.continent, dea.location,dea.date, dea.population, vac.new_vaccinations, 
sum(convert(int,vac.new_vaccinations)) over (partition by dea.location order by vac.location, dea.date) as  RollingPeopleVacc
from PortfolioProjects..CovidDeaths$ dea
join PortfolioProjects..CovidVaccinations$ vac
on dea.location=vac.location
and dea.date=vac.date
where dea.continent is not null
--order by 2,3)

SELECT *, (RollingPeopleVaccinated/Population)*100
From PopVsVac

--temp table


--Create View