CREATE DATABASE [db_Dota_sql]
GO

USE [db_Dota_sql]
GO

CREATE TABLE Heroes(
    HeroId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Role NVARCHAR(50),
    Attribute NVARCHAR(50),
    AttackType NVARCHAR(50)
);

CREATE TABLE Matches(
    MatchId INT PRIMARY KEY IDENTITY(1,1),
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    WinningTeam NVARCHAR(50)
);

CREATE TABLE Players(
    PlayerId INT PRIMARY KEY IDENTITY(1,1),
    Nickname NVARCHAR(100) NOT NULL UNIQUE,
    Team NVARCHAR(100),
    MMR INT
);

CREATE TABLE Items(
    ItemId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Cost INT
);

CREATE TABLE MatchPlayers(
    MatchPlayerId INT PRIMARY KEY IDENTITY(1,1),
    MatchId INT,
    PlayerId INT,
    HeroId INT,
    Kills INT,
    Deaths INT,
    Assists INT,
    GoldPerMinute INT,
    ExperiencePerMinute INT,
    ItemId INT
);

CREATE TABLE Teams(
    TeamId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE
);

CREATE TABLE TeamPlayers(
    TeamPlayerId INT PRIMARY KEY IDENTITY(1,1),
    TeamId INT,
    PlayerId INT,
    JoinDate DATE
);

CREATE TABLE Abilities(
    AbilityId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(MAX)
);

CREATE TABLE HeroAbilities(
    HeroAbilityId INT PRIMARY KEY IDENTITY(1,1),
    HeroId INT,
    AbilityId INT
);

CREATE TABLE MatchObjectives(
    ObjectiveId INT PRIMARY KEY IDENTITY(1,1),
    MatchId INT,
    ObjectiveType NVARCHAR(100),
    Description NVARCHAR(MAX),
    CompletionTime DATETIME
);

CREATE TABLE Tournaments(
    TournamentId INT PRIMARY KEY IDENTITY(1,1),
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Organizer NVARCHAR(100),
    StartDate DATE,
    EndDate DATE
);

CREATE TRIGGER check_match_end_time
ON Matches
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE EndTime <= StartTime)
    BEGIN
        RAISERROR('End time must be after start time', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_mmr
ON Players
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE MMR < 0)
    BEGIN
        RAISERROR('MMR cannot be negative', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_join_date
ON TeamPlayers
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE JoinDate > GETDATE())
    BEGIN
        RAISERROR('Join date cannot be in the future', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_unique_hero_ability
ON HeroAbilities
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM HeroAbilities ha INNER JOIN inserted i ON ha.HeroId = i.HeroId AND ha.AbilityId = i.AbilityId)
    BEGIN
        RAISERROR('This hero already has this ability', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_tournament_dates
ON Tournaments
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE EndDate <= StartDate)
    BEGIN
        RAISERROR('End date must be after start date', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_item_cost
ON Items
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted WHERE Cost < 0)
    BEGIN
        RAISERROR('Item cost cannot be negative', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_unique_ability_name
ON Abilities
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Abilities a INNER JOIN inserted i ON a.Name = i.Name)
    BEGIN
        RAISERROR('Ability name must be unique', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_completion_time
ON MatchObjectives
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM inserted i INNER JOIN Matches m ON i.MatchId = m.MatchId WHERE i.CompletionTime <= m.StartTime OR i.CompletionTime >= m.EndTime)
    BEGIN
        RAISERROR('Completion time must be within the match duration', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO

CREATE TRIGGER check_unique_team_name
ON Teams
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    IF EXISTS (SELECT 1 FROM Teams t INNER JOIN inserted i ON t.Name = i.Name)
    BEGIN
        RAISERROR('Team name must be unique', 16, 1);
        ROLLBACK TRANSACTION;
        RETURN;
    END;
END;
GO