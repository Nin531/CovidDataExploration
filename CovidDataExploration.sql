select *
from Covid..CovidDeaths$
order by 3, 4

select *
from Covid..CovidVaccinations$
order by 3, 4 

select location, date, total_cases, total_deaths, population
from Covid..CovidDeaths$
order by 1, 2

--total cases vs total deaths
select location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
from Covid..CovidDeaths$
--where location like '%india%'
order by 1, 2

--total cases vs population
select location, date, total_cases, population, (total_deaths/population)*100 as PercentPopulationInfected
from Covid..CovidDeaths$
--where location like '%india%'
order by 1, 2

--highest infection rate comapred to population
select location, population, max(total_cases) as HighestInfectionCount, max((total_deaths/total_cases))*100 as PercentPopulationInfected
from Covid..CovidDeaths$
group by location, population
order by PercentPopulationInfected desc

--highest death count per population
select location, max(cast(total_deaths as int)) as TotalDeathCount
from Covid..CovidDeaths$
where continent is not null
group by location
order by TotalDeathCount desc

--highest death count per continent
select location, max(cast(total_deaths as int)) as TotalDeathCount
from Covid..CovidDeaths$
where continent is null
group by location
order by TotalDeathCount desc

--total cases vs total deaths continent wise
select sum(new_cases) as total_cases, sum(cast(new_deaths as int)) as total_deaths, sum(cast(new_deaths as int))/sum(new_cases)*100 as DeathPercentage
from Covid..CovidDeaths$
where continent is not null
order by 1, 2

--total popultion vs vaccination
select *
from Covid..CovidDeaths$ dea
join Covid..CovidDeaths$ vac
    on dea.location = vac.location
	and dea.date = vac.date

select dea.continent, dea.location, dea.date, dea.population,  vac.new_vaccinations
from Covid..CovidDeaths$ dea
join Covid..CovidDeaths$ vac
    on dea.location = vac.location
	and dea.date = vac.date
where dea.continent is not null
order by 2, 3
 
