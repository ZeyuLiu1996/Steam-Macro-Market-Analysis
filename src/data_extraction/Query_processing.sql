
DECLARE @jsonContent NVARCHAR(MAX)

SELECT @jsonContent = BulkColumn --将数据变成一大块
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_Game_Rating_Prediction_Project\src\data_extraction\datas\all_steam_data_part_1.json', SINGLE_CLOB) AS j --如果你的目的是读取文件内容到 SQL Server 中，你应该继续使用OPENROWSET。当我们提到“bulk”操作时，通常是指批量处理数据的方式。比如 SQL Server 的 BULK INSERT 或者你之前提到的使用 BULK 选项从文件中读取数据。；SINGLE_NCLOB 的选项指明，你希望将文件的内容作为一个连续的大型字符对象（CLOB，Character Large OBject）读入

SELECT 
      DISTINCT SteamID.[key] AS steamid,
      player.personaname,
      player.profileurl,
      player.loccountrycode,
      DATEADD(SECOND, CAST(player.timecreated AS BIGINT), '1970-01-01T00:00:00Z') AS timecreated_converted,
      game.game_count,
      (SELECT COUNT(*) 
      FROM OPENJSON(JSON_QUERY(SteamID.[value],'$.player_friends.friendslist.friends'))) AS friends_count


FROM 
    OPENJSON(@jsonContent) AS steamid_object
    CROSS APPLY OPENJSON(steamid_object.[value]) AS SteamID
    CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value], '$.player_info.response.players')) WITH (
          personaname NVARCHAR(20) '$.personaname',
          profileurl NVARCHAR(MAX) '$.profileurl',
          timecreated BIGINT '$.timecreated',
          loccountrycode NVARCHAR(20) '$.loccountrycode'
    ) AS player
    CROSS APPLY OPENJSON(JSON_QUERY(SteamID.[value],'$.player_games.response')) WITH(
          game_count INT '$.game_count'
    ) AS game


    --JSON_VALUE：用于从 JSON 字符串中提取一个标量值（如字符串、数字或布尔值）。如果路径表达式选择的是标量值，则使用 JSON_VALUE。
    --JSON_QUERY：用于从 JSON 字符串中提取一个对象或数组。它返回的是一个 JSON 片段。如果路径表达式选择的是一个 JSON 对象或数组，应该使用 JSON_QUERY。

ORDER BY game_count ASC