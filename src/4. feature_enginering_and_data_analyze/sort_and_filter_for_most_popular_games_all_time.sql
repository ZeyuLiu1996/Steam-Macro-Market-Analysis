/*
构建参数(美元/小时（中位数）），观察每小时最贵的游戏前100名
*/

SELECT TOP(100)*,([price]/[playtime_forever_median])AS hours_per_dollar 
FROM [steam].[dbo].[most_frequent_play_game_all_timelist]
WHERE ([playtime_forever_median] >0) AND ([price]>0) AND([playtime_forever_count]>=3)
ORDER BY [hours_per_dollar] DESC


/*
筛选最热门的游戏
*/
SELECT *,([price]/[playtime_forever_median])AS hours_per_dollar 
FROM [steam].[dbo].[most_frequent_play_game_all_timelist]
WHERE [playtime_forever_median] >0 
ORDER BY [playtime_forever_count] DESC


/*
基于count值，筛选变异系数最低的，观察这些游戏为何大家都保持相似的游戏时长，是什么类型
*/
SELECT *,([price]/[playtime_forever_median])AS hours_per_dollar 
FROM [steam].[dbo].[most_frequent_play_game_all_timelist]
WHERE ([playtime_forever_median] >0) AND ([playtime_forever_count]>=3)  
ORDER BY [playtime_forever_cv] ASC , [playtime_forever_count] DESC

/*
筛选玩家游玩时间最长的游戏
*/
SELECT *,([price]/[playtime_forever_median])AS hours_per_dollar 
FROM [steam].[dbo].[most_frequent_play_game_all_timelist]
WHERE ([playtime_forever_median] >0) AND ([playtime_forever_count]>=3)  
ORDER BY [playtime_forever_median] DESC , [playtime_forever_count] DESC
