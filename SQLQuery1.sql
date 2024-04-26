USE [db_Dota_sql]
GO

INSERT INTO Heroes (Name, Role, Attribute, AttackType)
VALUES 
    ('Anti-Mage', 'Carry', 'Agility', 'Melee'),
    ('Crystal Maiden', 'Support', 'Intelligence', 'Ranged'),
    ('Axe', 'Initiator', 'Strength', 'Melee');

INSERT INTO Matches (StartTime, EndTime, WinningTeam)
VALUES     
    ('2024-04-26 15:00:00', '2024-04-26 16:30:00', 'Radiant'),
    ('2024-04-27 14:00:00', '2024-04-27 15:45:00', 'Dire');

INSERT INTO Players (Nickname, Team, MMR)
VALUES     
    ('Player1', 'Radiant', 2500),
    ('Player2', 'Dire', 2600),
    ('Player3', 'Radiant', 2400);

INSERT INTO Items (Name, Cost)
VALUES 
    ('Blink Dagger', 2250),
    ('Observer Ward', 75),
    ('Town Portal Scroll', 50);

INSERT INTO MatchPlayers (MatchId, PlayerId, HeroId, Kills, Deaths, Assists, GoldPerMinute, ExperiencePerMinute, ItemId)
VALUES     
    (1, 1, 1, 5, 2, 10, 400, 350, 1),
    (1, 2, 2, 3, 4, 15, 300, 300, 2),
    (2, 3, 3, 8, 1, 7, 450, 400, 3);

INSERT INTO Teams (Name)
VALUES 
    ('Radiant'),
    ('Dire');

INSERT INTO TeamPlayers (TeamId, PlayerId, JoinDate)
VALUES 
    (1, 1, '2024-01-01'),
    (2, 2, '2024-02-01'),
    (1, 3, '2024-03-01');

INSERT INTO Abilities (Name, Description)
VALUES     
    ('Blink', 'Teleport to a target point up to 1200 units away.'),
    ('Frostbite', 'Freezes a target enemy unit in a block of ice, disabling it and dealing damage per second.'),
    ('Berserker''s Call', 'Axe taunts nearby enemy units, forcing them to attack him for a short duration.');

INSERT INTO HeroAbilities (HeroId, AbilityId)
VALUES     
    (1, 1),
    (2, 2),
    (3, 3);

INSERT INTO MatchObjectives (MatchId, ObjectiveType, Description, CompletionTime)
VALUES     
    (1, 'Destroy Tower', 'Radiant Tier 1 Tower destroyed', '2024-04-26 15:15:00'),
    (2, 'Roshan Kill', 'Dire killed Roshan', '2024-04-27 15:30:00');

INSERT INTO Tournaments (Name, Organizer, StartDate, EndDate)
VALUES     
    ('International 2024', 'Valve', '2024-07-01', '2024-08-30'),
    ('Major Tournament', 'ESL', '2024-05-15', '2024-05-20');
