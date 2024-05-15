DECLARE @jsonContent NVARCHAR(MAX);

SELECT @jsonContent = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_DA\data\raw\all_steam_data2.json', SINGLE_NCLOB) AS j;

SELECT 
   steamid.[key],
   player.personaname,
   player.profileurl,
   DATEADD(SECOND, player.timecreated, '1970-01-01T00:00:00Z') AS timecreated_converted,
   player.loccountrycode,
   player_games.game_count,
   player_games.games


FROM 
  OPENJSON(@jsonContent) AS steamid_object
  OUTER APPLY OPENJSON(steamid_object.[value]) AS steamids
  OUTER APPLY OPENJSON(steamids.[value]) AS steamid
  OUTER APPLY OPENJSON(JSON_QUERY(steamid.[value],'$.player_info.response.players')) WITH(
   personaname NVARCHAR(20) '$.personaname',
   profileurl NVARCHAR(MAX) '$.profileurl',
   timecreated BIGINT '$.timecreated',
   loccountrycode NVARCHAR(20) '$.loccountrycode'
  ) AS player
  OUTER APPLY OPENJSON(JSON_QUERY(steamid.[value],'$.player_games.response')) WITH(
   game_count INT '$.game_count',
   games NVARCHAR(MAX) '$.games' AS JSON
  ) AS player_games
