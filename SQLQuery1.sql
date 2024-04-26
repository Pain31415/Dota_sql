USE [db_Dota_sql]
GO

-- Select all data from Heroes table
SELECT * FROM Heroes;

-- Select specific columns from Matches table
SELECT MatchId, StartTime, EndTime FROM Matches;

-- Select players with MMR greater than 2500 from Players table
SELECT * FROM Players WHERE MMR > 2500;

-- Select items with cost less than or equal to 100 from Items table
SELECT * FROM Items WHERE Cost <= 100;

-- Select match players and their corresponding heroes from MatchPlayers table
SELECT mp.MatchPlayerId, p.Nickname AS PlayerName, h.Name AS HeroName
FROM MatchPlayers mp
INNER JOIN Players p ON mp.PlayerId = p.PlayerId
INNER JOIN Heroes h ON mp.HeroId = h.HeroId;

-- Select teams and their players from Teams and TeamPlayers tables
SELECT t.Name AS TeamName, p.Nickname AS PlayerName
FROM Teams t
INNER JOIN TeamPlayers tp ON t.TeamId = tp.TeamId
INNER JOIN Players p ON tp.PlayerId = p.PlayerId;

-- Select abilities and their descriptions from Abilities table
SELECT Name, Description FROM Abilities;

-- Select heroes and their abilities from Heroes and HeroAbilities tables
SELECT h.Name AS HeroName, a.Name AS AbilityName
FROM Heroes h
INNER JOIN HeroAbilities ha ON h.HeroId = ha.HeroId
INNER JOIN Abilities a ON ha.AbilityId = a.AbilityId;

-- Select match objectives from MatchObjectives table for a specific match
SELECT * FROM MatchObjectives WHERE MatchId = 1;

-- Select tournaments organized by Valve from Tournaments table
SELECT * FROM Tournaments WHERE Organizer = 'Valve';
