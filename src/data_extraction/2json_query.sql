DECLARE @jsonContent1 NVARCHAR(MAX)
DECLARE @jsonContent2 NVARCHAR(MAX)

-- 第一个 JSON 文件
SELECT @jsonContent1 = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_Game_Rating_Prediction_Project\src\data_extraction\datas\all_steam_data_part_1.json', SINGLE_CLOB) AS j

-- 第二个 JSON 文件
SELECT @jsonContent2 = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_Game_Rating_Prediction_Project\src\data_extraction\datas\all_steam_data_part_2.json', SINGLE_CLOB) AS j

-- 为了简化示例，我们创建一个临时表来存储解析的结果
CREATE TABLE TempDB1 (
  steamid NVARCHAR(100),
  personaname NVARCHAR(20),
  profileurl NVARCHAR(MAX),
  loccountrycode NVARCHAR(20),
  timecreated_converted DATETIME,
  game_count INT,
  friends_count INT
);

-- 插入第一个 JSON 文件解析的结果
INSERT INTO TempDB1
SELECT 
  DISTINCT SteamID.[key] AS steamid,
  player.personaname,
  player.profileurl,
  player.loccountrycode,
  DATEADD(SECOND, CAST(player.timecreated AS BIGINT), '1970-01-01T00:00:00Z') AS timecreated_converted,
  game.game_count,
  (SELECT COUNT(*) FROM OPENJSON(JSON_QUERY(SteamID.[value],'$.player_friends.friendslist.friends'))) AS friends_count
FROM 
  OPENJSON(@jsonContent1) AS steamid_object
  CROSS APPLY OPENJSON(steamid_object.[value]) AS SteamID
  CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value], '$.player_info.response.players')) WITH (
    personaname NVARCHAR(20) '$.personaname',
    profileurl NVARCHAR(MAX) '$.profileurl',
    timecreated BIGINT '$.timecreated',
    loccountrycode NVARCHAR(20) '$.loccountrycode'
  ) AS player
  CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value],'$.player_games.response')) WITH(
    game_count INT '$.game_count'
  ) AS game;

-- 插入第二个 JSON 文件解析的结果
INSERT INTO TempDB1
SELECT 
  DISTINCT SteamID.[key] AS steamid,
  player.personaname,
  player.profileurl,
  player.loccountrycode,
  DATEADD(SECOND, CAST(player.timecreated AS BIGINT), '1970-01-01T00:00:00Z') AS timecreated_converted,
  game.game_count,
  (SELECT COUNT(*) FROM OPENJSON(JSON_QUERY(SteamID.[value],'$.player_friends.friendslist.friends'))) AS friends_count
FROM 
  OPENJSON(@jsonContent2) AS steamid_object
  CROSS APPLY OPENJSON(steamid_object.[value]) AS SteamID
  CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value], '$.player_info.response.players')) WITH (
    personaname NVARCHAR(20) '$.personaname',
    profileurl NVARCHAR(MAX) '$.profileurl',
    timecreated BIGINT '$.timecreated',
    loccountrycode NVARCHAR(20) '$.loccountrycode'
  ) AS player
  CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value],'$.player_games.response')) WITH(
    game_count INT '$.game_count'
  ) AS game;
-- 这里只需更改 @jsonContent1 为 @jsonContent2 并保持其他相同
-- 现在 TempDB1 包含了两个 JSON 文件的合并数据
-- 你可以执行任何你需要的查询来查看这些数据
SELECT * FROM TempDB1;

-- 清理
DROP TABLE TempDB1;
