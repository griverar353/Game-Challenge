USE [Challenge]
GO
create table game
(	id 		int Identity(1,1),
	name		varchar(20) NOT NULL,
	strategy		char(2) NOT NULL,
	flag 		bit NOT NULL,
	CONSTRAINT ck_strategy CHECK (strategy='S' OR strategy='P'OR strategy='R'),
        CONSTRAINT uk_name UNIQUE (first_place),
        CONSTRAINT pk_ID PRIMARY KEY (id)
);
create table winners
(	championship		int NOT NULL,
	first_place		varchar(20) NOT NULL,
	
	points_earned		int NOT NULL,
CONSTRAINT uk_FirstPlace UNIQUE (first_place),
 CONSTRAINT uk_SecondPlace UNIQUE (first_place),
CONSTRAINT ck_points CHECK (points_earned= 3 or points_earned=1), 
        CONSTRAINT pk_tournament PRIMARY KEY (championship)
);



DROP PROCEDURE Sp_ASKWinners
DROP PROCEDURE SP_SaveGame
SaveFirstPlaceAndSecondPlace(firstplace, 3);

CREATE PROCEDURE SP_SaveGame
(@tname varchar(20),
@tstrategy char(2),
@tflag bit) AS
INSERT INTO [dbo].[game]
           ([name]
           ,[strategy]
           ,[flag])
     VALUES
           (@tname,@tstrategy,@tflag)
GO

Procedure [dbo].[SP_SaveWinners](
@vfirst_place varchar(20),
@vpoints_earned int) AS 
BEGIN
INSERT INTO [dbo].[winners]
           ([first_place]
           ,[points_earned])
     VALUES
           (@vfirst_place,@vpoints_earned) 
		   END

CREATE PROCEDURE [dbo].[SP_ASKStrategy]
AS
BEGIN 
SELECT name,strategy from game  ORDER BY id desc
END

CREATE PROCEDURE [dbo].[SP_ASKChampion]
AS
BEGIN 
SELECT TOP 1 first_place from winners WHERE points_earned = 3 ORDER BY championship desc
END

CREATE PROCEDURE [dbo].[SP_ASKSecondPlace]
AS
BEGIN 
SELECT TOP 1 first_place from winners WHERE points_earned = 1 ORDER BY championship desc
END

CREATE PROCEDURE [dbo].[SP_ASKChampionPuntuation]
AS
BEGIN 
SELECT TOP 1 first_place,points_earned from winners  ORDER BY championship desc
END

CREATE PROCEDURE DeleteEverythingOnDB
AS
BEGIN
	DELETE game
	DELETE winners
END
