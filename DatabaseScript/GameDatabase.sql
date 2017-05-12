IF EXISTS(SELECT 1 FROM master.dbo.sysdatabases WHERE name = 'GameDatabase')
BEGIN 
	DROP DATABASE GameDatabase
	print '' print '*** dropping database GameDatabase'
END
GO

print ''print '*** creating database GameDatabase'
GO
CREATE DATABASE GameDatabase
GO

print ''print '***using database GameDatabase'
GO
USE [GameDatabase]
GO

GO
print ''print '***CREATE Player TABLE'
GO

/* ***** Object: Table [dbo].[Player] ***** */
CREATE TABLE [dbo].[Player](
	[PlayerID]			[int] IDENTITY (100000,1) 		NOT NULL,
	[UserName]			[varchar] (20)					NOT NULL,
	[Email]				[varchar] (100)					NOT NULL,
	[PasswordHash]		[varchar] (100)	/*NOT NULL DEFAULT('9c9064c59f1ffa2e174ee754d2979be80dd30db552ec03e7e327e9b1a4bd594e')*/,
	[RoleID]			[int]			NOT NULL DEFAULT(0),
	
	[SavedLocationX]	[int]			NOT NULL DEFAULT(0),
	[SavedLocationY]	[int]			NOT NULL DEFAULT(0),
	[SavedLocationZ]	[int]			NOT NULL DEFAULT(0),
	[SavedHealth]		[int]			NOT NULL DEFAULT(100),
	[SavedImageSet]		[int]			NOT NULL DEFAULT(0),
	[SavedItem]			[int]			NOT NULL DEFAULT(0),
	[Ban]				[bit]			NOT NULL DEFAULT(0),
	CONSTRAINT [pk_PlayerID] PRIMARY KEY([PlayerID] ASC),
	CONSTRAINT [ak_UserName] UNIQUE ([UserName] ASC),
	CONSTRAINT [ak_Email] UNIQUE ([Email] ASC)
)
GO

GO
print ''print '***CREATE Player TABLE'
GO

/* ***** Object: Table [dbo].[Server] ***** */
CREATE TABLE [dbo].[Server](
	[PlayerID]			[int] 		NOT NULL,
	[UserName]			[varchar] (20)	,
	[LocationX]			[int]			,
	[LocationY]			[int]			,
	[LocationZ]			[int]			,
	[Health]			[int]			NOT NULL DEFAULT(100),
	[imageSet]			[int]   		NOT NULL DEFAULT(0),
	[EquiptItem]		[int]			NOT NULL DEFAULT(0),
	[Active]			[Bit]			NOT NULL DEFAULT(0),
	CONSTRAINT [ak_ServerUserName] UNIQUE ([UserName] ASC),
	CONSTRAINT [ak_ServerPlayerID] UNIQUE ([PlayerID] ASC)
)
GO

GO
print ''print '***Creating PlayerID foreign key between Player and Server'
GO 

GO 
ALTER TABLE [dbo].[Server] WITH NOCHECK
	ADD CONSTRAINT [FK_PlayerID] FOREIGN KEY ([PlayerID])
	REFERENCES [dbo].[Player]([PlayerID])
	ON UPDATE CASCADE
GO

GO
print ''print '***CREATE ItemCollection TABLE'
GO

CREATE TABLE [dbo].[ItemCollection](
	[ItemID]			[int] 	IDENTITY (100000,1) 	NOT NULL,
	[ItemListID]		[int]  	NOT NULL,
	[PlayerID]			[int] 	,
	[ItemLocationX]		[int]	,
	[ItemLocationY]		[int]	,
	[ItemLocationZ]		[int]	,
	[ItemHealth]		[int]	,
	CONSTRAINT [ItemId] UNIQUE ([ItemID] ASC)
)
GO

GO
print ''print '***CREATE ItemList TABLE'
GO

CREATE TABLE [dbo].[ItemList](
	[ItemListID]		[int] IDENTITY (100000,1) 	NOT NULL,
	[ItemName]			[varchar] (50) 				NOT NULL,
	[ItemDescription]	[varchar] (150)				NOT NULL,
	[ItemTypeID]		[int]						NOT NULL,
	[Damage]			[int]						NOT NULL,
	CONSTRAINT [ItemListId] UNIQUE ([ItemListID] ASC)

)
GO


GO
print ''print '***CREATE ItemType TABLE'
GO

CREATE TABLE [dbo].[ItemType](
	[ItemTypeID]			[int] IDENTITY (100000,1)	NOT NULL,
	[ItemTypeDescription]	[varchar] (150)	NOT NULL,
	CONSTRAINT [ItemTypeId] UNIQUE ([ItemTypeID] ASC)
)
GO




GO
print ''print '***CREATE EnvirnmentList TABLE'
GO

CREATE TABLE [dbo].[EnvirnmentList](
	[EnvirnmentListID]			[int] IDENTITY (200000,1) 		NOT NULL,
	[EnvirnmentName]			[varchar] (50)	NOT NULL,
	[EnvirnmentDescription]		[varchar] (150)	,
	[EnvirnmentType]			[int]			,
	CONSTRAINT [EnvirnmentListID] UNIQUE ([EnvirnmentListID] ASC),
	CONSTRAINT [EnvirnmentName] UNIQUE ([EnvirnmentName] ASC)
)
GO

GO
print ''print '***CREATE Envirnment TABLE'
GO

CREATE TABLE [dbo].[Envirnment](
	[EnvirnmentID]			[int] IDENTITY (200000,1)		NOT NULL,
	[EnvirnmentListID]		[int] 	NOT NULL,
	[EnvirnmentLocationX]	[int]	,
	[EnvirnmentLocationY]	[int]	,
	[EnvirnmentLocationZ]	[int]	,
	CONSTRAINT [EnvirnmentID] UNIQUE ([EnvirnmentID] ASC)
)
GO

GO
print ''print '***Creating EnvirnmentListID foreign key between Envirnment and EnvirnmentList'
GO 

GO 
ALTER TABLE [dbo].[Envirnment] WITH NOCHECK
	ADD CONSTRAINT [FK_EnvirnmentEnvirnmentListID] FOREIGN KEY ([EnvirnmentListID])
	REFERENCES [dbo].[EnvirnmentList]([EnvirnmentListID])
	ON UPDATE CASCADE
GO

GO
print ''print '***Creating ItemTypeID foreign key between ItemList and ItemType'
GO 

GO 
ALTER TABLE [dbo].[ItemList] WITH NOCHECK
	ADD CONSTRAINT [FK_ItemListItemTypeID] FOREIGN KEY ([ItemTypeID])
	REFERENCES [dbo].[ItemType]([ItemTypeID])
	ON UPDATE CASCADE
GO

GO
print ''print '***Creating ItemListID foreign key between ItemList and ItemCollection'
GO 

GO 
ALTER TABLE [dbo].[ItemCollection] WITH NOCHECK
	ADD CONSTRAINT [FK_ItemItemListID] FOREIGN KEY ([ItemListID])
	REFERENCES [dbo].[ItemList]([ItemListID])
	ON UPDATE CASCADE
GO

GO
print ''print '***Creating PlayerID foreign key between Player and ItemCollection'
GO 

GO 
ALTER TABLE [dbo].[ItemCollection] WITH NOCHECK
	ADD CONSTRAINT [FK_ItemPlayerID] FOREIGN KEY ([PlayerID])
	REFERENCES [dbo].[Player]([PlayerID])
	ON UPDATE CASCADE
GO


GO
print ''print '***Inserting a few Player records'
GO

INSERT INTO [dbo].[Player]
	([UserName],[Email],[PasswordHash])
	VALUES
		('BobSmith','bob@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'),
		('JoeSmith','joe@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'),
		('DenTones','Den@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'),
		('TomSmith','tom@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'),
		('JimBone','Jim@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342'),
		('GeneJones','Gene@email.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342')
GO




GO
print ''print '***Inserting a few Server records'
GO
INSERT INTO [dbo].[Server]
	([PlayerID],[UserName],[LocationX],[LocationY],[LocationZ],[Health],[Active])
	VALUES
		
		('100001','JoeSmith', '200', '0', '0', '95','1'),
		('100002','DenTones', '150', '0', '0', '3','1')
		
GO


GO
print ''print '***Inserting a Admin and Developer user'
GO

INSERT INTO [dbo].[Player]
	([UserName],[Email],[PasswordHash],[RoleID])
	VALUES
		('BobThorne','bobby.a.thorne@gmail.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342',2),
		('BobThor','bobby.a.thorne1@gmail.com','b03ddf3ca2e714a6548e7495e2a03f5e824eaac9837cd7f159c67b90fb4b7342',3)
		
GO

INSERT INTO [dbo].[ItemType]
	([ItemTypeDescription])
	VALUES
	('Tool'),
	('Weapon'),
	('Food'),
	('Medican')
GO


INSERT INTO [dbo].[ItemList]
	([ItemName],[ItemDescription],[ItemTypeID],[Damage])
	VALUES
	('Axe','You swing this to cut down trees. It maybe used as a weapon', 100000, -15),
	('Hammer','You swing to fix things. It maybe used as a weapon', 100000, -10),
	('Pick Axe','You swing this to mine resources. It maybe used as a weapon', 100000, -20),
	('Dagger','Low damage weapon good for hitting your taget quickly', 100001, -20),
	('Sword','Mid damage weapon good for a slow moving target', 100001, -45),
	('Good Sword','High damage weapon good for a Mediam moving target', 100001, -60),
	('Great Sword','High damage weapon good for a slow moving target', 100001, -75),
	('Sandwitch','Hungry? Have a snack. Regain a little health', 100002, 10),
	('Fries','Hungry? Have a snack. Regain a little health', 100002, 5),
	('Pizza','Hungry? Have a snack. Regain a little health', 100002, 100),
	('Pain Killers','Hurting? Have a pill. Regain some health', 100003, 25),
	('Bandage','Hurting? Rap it up. Regain health', 100003, 50),
	('Medkit','Hurting? Kit it up. Regain all your health', 100003, 100)
GO


GO 
print ''print '***Create Security Table'
/*This table holds security questions and attempts so it can send an email to 
player if they attempted to use their account. Can lock account if 
max attempts have been reached and uses security questions if password is 
lost.*/
GO
CREATE TABLE [dbo].[Security](
	[UserName]		[varchar](20)		NOT NULL,
	[NumberOfAttempts] [int]			NOT NULL DEFAULT(0),
	[TimeOfLastAttempt] [DateTime]		,
	[Locked]			[bit]			NOT NULL DEFAULT(0),
	[SecurityQuestion1] [varchar](100) 	NOT NULL,
	[SecurityQuestion2] [varchar](100) 	NOT NULL,
	[AnswerHash1]		[varchar] (100) NOT NULL,
	[AnswerHash2]		[varchar] (100) NOT NULL,
	CONSTRAINT [pk_SecurityUserName] PRIMARY KEY([UserName] ASC)
)
GO

print ''print '***Create Role Table'
GO
CREATE TABLE [dbo].[Role](
	[RoleID]			[int]			NOT NULL,
	[RoleDescription]	[varchar] (100),
	CONSTRAINT [pk_RoleID] PRIMARY KEY([RoleID] ASC)
)
GO

GO
print ''print '***Inserting Roles into the Role table'
GO

INSERT INTO [dbo].[Role]
	([RoleID],[RoleDescription])
	VALUES
		(0,'Player'),
		(1,'Spectator'),
		(2,'Administrator'),
		(3,'Developer')
GO


GO
print ''print '***Creating UserName foreign key between Player and Security Table'
GO 

GO 
ALTER TABLE [dbo].[Security] WITH NOCHECK
	ADD CONSTRAINT [FK_UserName] FOREIGN KEY ([UserName])
	REFERENCES [dbo].[Player]([UserName])
	ON UPDATE CASCADE
GO

GO
print ''print '***Creating RoleID foreign key between Player and Role Table'
GO 

GO 
ALTER TABLE [dbo].[Player] WITH NOCHECK
	ADD CONSTRAINT [FK_RoleID] FOREIGN KEY ([RoleID])
	REFERENCES [dbo].[Role]([RoleID])
	ON UPDATE CASCADE
GO

GO
print '' print'***Creating sp_add_new_player'
GO
CREATE PROCEDURE [dbo].[sp_add_new_player]
	(
	@UserName 		varchar(20),
	@Email 			varchar(100),
	@PasswordHash 	varchar(100)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Player]
			([UserName],[Email],[PasswordHash])
			VALUES (@UserName, @Email, @PasswordHash)
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_add_new_ItemType'
GO
CREATE PROCEDURE [dbo].[sp_add_new_ItemType]
	(
	@ItemTypeDescription 	varchar(150)
	)
AS
	BEGIN
		INSERT INTO [dbo].[ItemType]
			([ItemTypeDescription])
			VALUES (@ItemTypeDescription)
		RETURN @@ROWCOUNT
	END
GO


GO
print '' print'***Creating sp_add_player_security'
GO
CREATE PROCEDURE [dbo].[sp_add_player_security]
	(
	@UserName 				varchar(20),
	@SecurityQuestion1 			varchar(100),
	@SecurityQuestion2		 	varchar(100),
	@AnswerHash1				varchar(100),
	@AnswerHash2				varchar(100)
	)
AS
	BEGIN
		INSERT INTO [dbo].[Security]
			([UserName],[SecurityQuestion1],[SecurityQuestion2],[AnswerHash1],[AnswerHash2])
			VALUES (@UserName, @SecurityQuestion1, @SecurityQuestion2,@AnswerHash1,@AnswerHash2)
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_retrieve_player_by username'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_by_username]
	(
	@Username 		varchar(20)
	)
AS
	BEGIN
		SELECT PlayerID, UserName, Email, RoleID, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem,Ban
		FROM Player
		WHERE UserName = @Username
	END
GO

GO
print '' print'***Creating sp_retrieve_player_by_similar_username'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_by_similar_username]
	(
	@Username 		varchar(20)
	)
AS
	BEGIN
		SELECT PlayerID, UserName, Email, RoleID, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem,Ban
		FROM Player
		WHERE UserName like CONCAT('%',@Username,'%');
	END
GO



GO
print '' print'***Creating sp_retrieve_player_on_server_by_username'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_on_server_by_username]
	(
	@Username 		varchar(20)
	)
AS
	BEGIN
		SELECT PlayerID, UserName, LocationX, LocationY, LocationZ, Health, ImageSet, EquiptItem
		FROM Server
		WHERE UserName = @Username
	END
GO

GO
print '' print'***Creating sp_retrieve_player_on_server_that_are_active'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_on_server_that_are_active]
AS
	BEGIN
		SELECT PlayerID, UserName, LocationX, LocationY, LocationZ, Health, ImageSet, EquiptItem
		FROM Server
		WHERE Active = 1
	END
GO

GO
print '' print'***Creating sp_retrieve_player_by_email'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_by_email]
	(
	@Email 		varchar(100)
	)
AS
	BEGIN
		SELECT PlayerID, UserName, Email, RoleID, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem,Ban
		FROM Player
		WHERE Email = @Email
	END
GO

GO
print '' print'***Creating sp_retrieve_player_by_id'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_by_id]
	(
	@id 	[Int]
	)
AS
	BEGIN
		SELECT PlayerID, UserName, Email, RoleID, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem,Ban
		FROM Player
		WHERE PlayerID = @id
	END
GO


GO
print '' print'***Creating sp_retrieve_player_role'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_player_role]
	(
	@PlayerID 		int
	)
AS
	BEGIN
		SELECT [Role].RoleID, [Role].RoleDescription
		FROM Player, Role
		WHERE [Player].[PlayerID] = @PlayerID
		AND [Player].[RoleID] = [Role].[RoleID] 
	END
GO

GO
print '' print'***Creating sp_add_player_to_server'
GO
CREATE PROCEDURE [dbo].[sp_add_player_to_server]
	(
		@PlayerID		int
	)
	AS
		BEGIN
			INSERT INTO Server
			(
				PlayerID		,
				UserName		,
				LocationX		, 
				LocationY 		, 
				LocationZ 		,
				Health  		,
				ImageSet		,
				EquiptItem
			)
			SELECT PlayerID, UserName, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem
			From Player
			WHERE Player.PlayerID = @PlayerID
	END
GO


GO
print '' print'***Creating sp_update_saved_data'
GO
CREATE PROCEDURE [dbo].[sp_update_saved_data]
	(
	@PlayerID 		int,
	@LocationX		int,
	@LocationY		int,
	@LocationZ		int,
	@EquiptItem		int,
	@Health			int
	)
AS
	BEGIN
	UPDATE Player
			SET SavedLocationX = @LocationX, 
				SavedLocationY = @LocationY, 
				SavedLocationZ = @LocationZ,
				SavedItem = @EquiptItem,
				SavedHealth = @Health
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_update_active'
GO
CREATE PROCEDURE [dbo].[sp_update_to_active]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE Server
			SET Active = 1 
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_update_inactive'
GO
CREATE PROCEDURE [dbo].[sp_update_to_inactive]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE Server
			SET Active = 0 
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_delete_player_from_server'
GO
CREATE PROCEDURE [dbo].[sp_delete_player_from_server]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE Player
			SET Player.SavedLocationX = 0, 
				Player.SavedLocationY = 0, 
				Player.SavedLocationZ = 0,
				Player.SavedItem = 0,
				Player.SavedHealth = Server.Health
			FROM Server
			WHERE Server.PlayerID = Player.PlayerID 
					AND Player.PlayerID = @PlayerID
		DELETE FROM Server 
		WHERE PlayerID = @PlayerID
		
		RETURN @@ROWCOUNT
	END
GO
GO
print '' print'***Creating sp_delete_player_from_server_and_update_SavedLocation'
GO
CREATE PROCEDURE [dbo].[sp_delete_player_from_server_and_update_SavedLocation]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE Player
			SET Player.SavedLocationX = Server.LocationX, 
				Player.SavedLocationY = Server.LocationY, 
				Player.SavedLocationZ = Server.LocationZ,
				Player.SavedItem = Server.EquiptItem,
				Player.SavedHealth = Server.Health
			FROM Server
			WHERE Server.PlayerID = Player.PlayerID 
					AND Player.PlayerID = @PlayerID
		DELETE FROM Server 
		WHERE PlayerID = @PlayerID
		
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_delete_player_from_server_complete'
GO
CREATE PROCEDURE [dbo].[sp_delete_player_from_server_complete]
	(
	@PlayerID 		int
	)
AS
	BEGIN
		DELETE FROM Server 
		WHERE PlayerID = @PlayerID
		
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_retrieve_players_on_server'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_players_on_server]
AS
	BEGIN
		SELECT PlayerID, UserName, LocationX, LocationY, LocationZ, Health, ImageSet,Active
		FROM Server
	END
GO

GO
print '' print'***Creating sp_retrieve_players_online'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_players_online]
AS
	BEGIN
		SELECT PlayerID, UserName, LocationX, LocationY, LocationZ, Health, ImageSet, Active
		FROM Server
		WHERE Active = 1
	END
GO

GO
print '' print'***Creating sp_retrieve_players'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_players]
AS
	BEGIN
		SELECT PlayerID, UserName, Email, RoleID, SavedLocationX, SavedLocationY, SavedLocationZ, SavedHealth, SavedImageSet, SavedItem, Ban
		FROM Player
	END
GO

GO
print '' print'***Creating sp_retrieve_players_on_server_within_range'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_players_on_server_within_range]
	(
		@PlayerX		int,
		@PlayerY		int,
		@PlayerZ 		int,
		@Range			int
	)
AS
	BEGIN
		SELECT PlayerID, UserName, LocationX, LocationY, LocationZ, Health, ImageSet, Active
		FROM Server
		WHERE (@PlayerX-@Range)<LocationX AND (@PlayerX+@Range)>LocationX AND
				(@PlayerY-@Range)<LocationY AND (@PlayerY+@Range)>LocationY AND
				(@PlayerZ-@Range)<LocationZ AND (@PlayerZ+@Range)>LocationZ 
	END
GO

GO
print '' print'***Creating sp_update_passwordHash'
GO
CREATE PROCEDURE [dbo].[sp_update_passwordHash]
	(
	@PlayerID			int,
	@OldPasswordHash	varchar(100),
	@NewPasswordHash	varchar(100)
	)
As
	BEGIN
		UPDATE Player
			SET PasswordHash = @NewPasswordHash
			WHERE PlayerID = @PlayerID
			AND PasswordHash = @OldPasswordHash
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_update_passwordHash_by_username'
GO
CREATE PROCEDURE [dbo].[sp_update_passwordHash_by_username]
	(
	@UserName			VARCHAR(20),
	@OldPasswordHash	varchar(100),
	@NewPasswordHash	varchar(100)
	)
As
	BEGIN
		UPDATE Player
			SET PasswordHash = @NewPasswordHash
			WHERE UserName = @UserName
			AND PasswordHash = @OldPasswordHash
		RETURN @@ROWCOUNT
	END
GO


/* NEEDS TO BE TESTED TO MAKE SURE THAT IT UPDATES THE RIGHT PLAYER */
GO
print '' print'***Creating sp_update_location'
GO
CREATE PROCEDURE [dbo].[sp_update_player_SavedLocation]
	(
	@PlayerID	int
	)
As
	BEGIN
		UPDATE Player
			SET Player.SavedLocationX = Server.LocationX, 
				Player.SavedLocationY = Server.LocationY, 
				Player.SavedLocationZ = Server.LocationZ,
				Player.SavedImageSet = Server.ImageSet,
				Player.SavedHealth = Server.Health
			FROM Server
			WHERE Server.PlayerID = Player.PlayerID 
					AND Player.PlayerID = @PlayerID
			
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_retrieve_number_of_players_on_server'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_number_of_players_on_server]
As 
	BEGIN
		SELECT COUNT(Username)
		FROM Server
		WHERE Active=1
	END
GO

GO
print '' print'***Creating sp_authenticate_player'
GO
CREATE PROCEDURE [dbo].[sp_authenticate_player]
	(
	@Username		varchar(20),
	@PasswordHash 	varchar(100)
	)
As 
	BEGIN
		SELECT COUNT(Username)
		FROM Player
		WHERE Username = @Username
		AND PasswordHash = @PasswordHash
	END
GO

GO
print '' print'***Creating sp_authenticate_player_by_email'
GO
CREATE PROCEDURE [dbo].[sp_authenticate_player_by_email]
	(
	@Email		varchar(100),
	@PasswordHash 	varchar(100)
	)
As 
	BEGIN
		SELECT COUNT(Email)
		FROM Player
		WHERE Email = @Email
		AND PasswordHash = @PasswordHash
	END
GO

GO
print '' print'***Creating sp_update_moved'
GO
/* This may need a old location to check to make sure it did not change*/
CREATE PROCEDURE [dbo].[sp_player_moved]
	(
	@PlayerID		int,
	@LocationX		int,
	@LocationY		int,
	@LocationZ		int,
	@ImageSet			int,
	@OldLocationX	int,
	@OldLocationY	int,
	@OldLocationZ	int
	)
As
	BEGIN
		UPDATE Server
			SET LocationX = @LocationX , LocationY = @LocationY, LocationZ = @LocationZ, ImageSet = @ImageSet 
			WHERE PlayerID = @PlayerID AND LocationX = @OldLocationX AND LocationY = @OldLocationY AND LocationZ = @OldLocationZ
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_add_new_item'
GO
CREATE PROCEDURE [dbo].[sp_add_new_item]
	(
	@ItemName 			varchar(50),
	@ItemDescription	varchar(150),
	@ItemTypeID 		Int,
	@Damage				Int
	)
AS
	BEGIN
		INSERT INTO [dbo].[ItemList]
			([ItemName],[ItemDescription],[ItemTypeID],[Damage])
			VALUES (@ItemName, @ItemDescription, @ItemTypeID,@Damage)
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_update_to_ban'
GO
CREATE PROCEDURE [dbo].[sp_update_to_ban]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE PLAYER
			SET Ban = 1 
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_update_to_unban'
GO
CREATE PROCEDURE [dbo].[sp_update_to_unban]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE PLAYER
			SET Ban = 0 
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO


GO
print '' print'***Creating sp_update_to_kick'
GO
CREATE PROCEDURE [dbo].[sp_update_to_kick]
	(
	@PlayerID 		int
	)
AS
	BEGIN
	UPDATE Server
			SET Active = 0 
			WHERE  PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO


GO
print '' print'***Creating sp_retrieve_all_ItemList'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_ItemList]
AS
	BEGIN
		SELECT ItemListID, ItemName, ItemDescription, ItemTypeID, Damage
		FROM ItemList
	END
GO

GO
print '' print'***Creating sp_retrieve_all_itemTypes'
GO
CREATE PROCEDURE [dbo].[sp_retrieve_all_itemTypes]
AS
	BEGIN
		SELECT ItemTypeDescription
		FROM ItemType
	END
GO

GO
print '' print'***Creating sp_delete_itemList'
GO
CREATE PROCEDURE [dbo].[sp_delete_itemList]
	(
	@ItemListID 	int
	)
AS
	BEGIN
		DELETE FROM ItemList 
		WHERE ItemListID = @ItemListID
		
		RETURN @@ROWCOUNT
	END
GO

GO
print '' print'***Creating sp_change_player_role'
GO
/* This may need a old location to check to make sure it did not change*/
CREATE PROCEDURE [dbo].[sp_change_player_role]
	(
	@PlayerID		int,
	@RoleID			int
	)
As
	BEGIN
		UPDATE PLAYER
			SET RoleId = @RoleID 
			WHERE PlayerID = @PlayerID
		RETURN @@ROWCOUNT
	END
GO

/*

Where I left off :


What needs to be done to the database:
image table and images to switch when walking and have taken damage and switched equipt item
Equitable Item table 

What is Done:
login sp 
server table so can add players to so it can draw them when they are in range


What Can be done with what I have:
From this point I should have everything needed to start a login and logout and an update password and security page. 
Add players to server so it can draw players on server within range
move player with sp_player_moved

For later:
Make sure before player is deleted from server there is a wait call so they can not exit right away but a delay.
Add table of envirnment object and in range sp for envir objects 
I may add a security question table for users to select from premade questions

how to check key pressed
while (key!=true)
            {
                var keypress = Console.ReadKey().Key.ToString();
                
                key = keypress.Equals("Spacebar");
              
            }
			

*/


