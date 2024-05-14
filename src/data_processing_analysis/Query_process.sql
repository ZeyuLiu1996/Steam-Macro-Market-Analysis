DECLARE @jsonContent1 NVARCHAR(MAX)
-- DECLARE @jsonContent2 NVARCHAR(MAX)

/*
导入抓取的JSON数据（注意地址更改为您本地的实际文件地址，或者数据库中地址），如果您创建了不止2个JSON文件，可以继续重复该部分操作
    OPENROWSET 是一个可以用来从文件中读取数据的函数。
    BULK 表示大批量数据加载。
    SINGLE_CLOB 表示将文件内容读取为单个字符大对象（CLOB）。
    BulkColumn 是一个虚拟列名，用来表示读取的内容。
    @jsonContent1 是一个变量，用来存储读取到的JSON数据。
*/
-- 第一个 JSON 文件
SELECT @jsonContent1 = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_DA\data\raw\test_file.json', SINGLE_CLOB) AS j

-- -- 第二个 JSON 文件
-- SELECT @jsonContent2 = BulkColumn
-- FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_Game_Rating_Prediction_Project\src\data_extraction\datas\all_steam_data_part_2.json', SINGLE_CLOB) AS j


/*
在SQL Server中创建一个名为 TempDB1 的临时表。这个临时表将用于存储Steam用户的一些信息
    steamid NVARCHAR(100): 用户的Steam ID，最大长度为100个字符。
    personaname NVARCHAR(20): 用户的昵称，最大长度为20个字符。
    profileurl NVARCHAR(MAX): 用户的Steam个人资料页面的URL，长度不定（使用 NVARCHAR(MAX)）。
    loccountrycode NVARCHAR(20): 用户所在国家的代码，最大长度为20个字符。
    timecreated_converted DATETIME: 用户创建Steam账户的时间，类型为日期时间。
    game_count INT: 用户拥有的游戏数量，类型为整数。
    friends_count INT: 用户的好友数量，类型为整数。
*/
CREATE TABLE TempDB1 (
  steamid NVARCHAR(100),
  personaname NVARCHAR(20),
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

/*
FROM OPENJSON(@jsonContent1) AS steamid_object：
    解析变量 @jsonContent1 中的JSON内容，生成一个包含键值对的行集，其中键名为 key，键值为 value。
    steamid_object 是为此行集指定的别名。

*/


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
