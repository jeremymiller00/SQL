-- Example of exercises completed on SQLZoo

-- Nested Select Statements

SELECT name FROM world
WHERE population >
(SELECT population FROM world
WHERE name='Russia')

SELECT name FROM world
WHERE continent = 'Europe'
AND gdp/population >
(SELECT gdp/population
FROM world
WHERE name = 'United Kingdom')

SELECT name, continent FROM world
WHERE continent =
(SELECT continent FROM world WHERE name  = 'Argentina') 
OR continent = (SELECT continent FROM world WHERE name = 'Australia')
ORDER BY name

SELECT name, population FROM world
WHERE population > (SELECT population FROM world WHERE name = 'Canada')
AND population < (SELECT population FROM world WHERE name = 'Poland')

SELECT name, 
    CONCAT(ROUND(100*population / (SELECT population 
                                FROM world 
                                WHERE name = 'Germany')) 
                                '%')
FROM world
WHERE continent = 'Europe'

-- Aggregate functions

SELECT SUM(gdp) 
FROM world 
WHERE continent = 'Africa'

SELECT COUNT(name)
FROM world
WHERE area > 1000000

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

SELECT continent, COUNT(name)
FROM world
GROUP BY continent

SELECT continent, COUNT(name)
FROM world
WHERE population > 10000000
GROUP BY continent

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) > 100000000

-- Joins

SELECT id,stadium,team1,team2
FROM game JOIN goal
ON (id=matchid)
WHERE goal.matchid = 1012
LIMIT 1

SELECT player, teamid, stadium, mdate
FROM game JOIN goal ON (id=matchid)
WHERE goal.teamid = 'GER'

SELECT team1, team2, player
FROM game JOIN goal
ON (id=matchid)
WHERE player LIKE 'Mario%'

SELECT player, teamid, coach, gtime
FROM goal JOIN eteam ON teamid=id
WHERE gtime<=10

SELECT mdate, teamname
FROM game JOIN eteam ON (team1=eteam.id)
WHERE coach = 'Fernando Santos'

SELECT player
FROM goal JOIN game
ON (id=matchid)
WHERE stadium = 'National Stadium, Warsaw'

SELECT DISTINCT player
FROM goal JOIN game ON (id=matchid) 
WHERE (team1='GER' OR team2='GER')
AND teamid <> 'GER'

SELECT teamname, COUNT(teamid) as 'goals'
FROM goal JOIN eteam ON teamid=id
GROUP BY teamname
ORDER BY teamname

SELECT stadium, COUNT(matchid) as 'goals'
FROM goal JOIN game ON matchid=id
GROUP BY stadium
ORDER BY goals DESC

