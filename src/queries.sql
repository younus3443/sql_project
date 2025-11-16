
-- #Total runs scored by team

select batting_team , sum(total_runs)
from deliveries
group by batting_team;

 
-- # Top batsman for Royal Challengers Bangalore

select batsman,sum(batsman_runs) as total
from deliveries
where batting_team='Royal Challengers Bangalore'
group by batsman
order by total desc limit 10;

-- #Foreign umpire analysis

select country,count(umpires)
from umpires
where country != 'India'
group by country;

-- #matches played by team by season
SELECT
    season,
    team,
    COUNT(*) AS matches_played
FROM (
    SELECT season, team1 AS team FROM matches
    UNION ALL
    SELECT season, team2 AS team FROM matches
) AS all_teams
GROUP BY season, team
ORDER BY season, team;


-- #Number of matches played per year in IPL
select season,count(*) as matches_played
from matches
group by season
order by season;

-- #Number of matches won per team per year in IPL.
SELECT 
    season,
    winner AS team,
    COUNT(*) AS total_wins
FROM matches
WHERE winner IS NOT NULL AND winner <> ''
GROUP BY season, winner
ORDER BY season, total_wins DESC;


-- Extra runs conceded per team in 2016
SELECT 
    d.bowling_team,
    SUM(d.extra_runs) AS total_extra_runs
FROM deliveries d
JOIN matches m 
    ON d.match_id = m.id
WHERE m.season = 2016
GROUP BY d.bowling_team
ORDER BY total_extra_runs DESC;


-- #Top 10 most economical bowlers

SELECT
    d.bowler,
    ROUND(SUM(d.total_runs - d.bye_runs - d.legbye_runs)::numeric 
          / (COUNT(*) / 6.0), 2) AS economy
FROM deliveries d
JOIN matches m
    ON d.match_id = m.id
WHERE m.season = 2015
  AND d.wide_runs = 0
  AND d.noball_runs = 0
GROUP BY d.bowler
HAVING COUNT(*) > 0
ORDER BY economy ASC
LIMIT 10;
