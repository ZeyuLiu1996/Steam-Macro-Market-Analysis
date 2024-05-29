/*
对于该部分的基础分析，请将相应的查询代码结果保存为CSV文件至本地
*/

-- 统计不同社区可见性状态的用户数量，可以看出，90%的用户愿意公开自己的信息
/*
3	18533 
1	622
2	1286

1 - 该用户的社区资料是私密的。这意味着只有用户自己可以查看其个人资料信息，其他人无法访问。
2 - 该用户的社区资料是友好的。这意味着只有用户的好友可以查看其个人资料信息，其他人无法访问。
3 - 该用户的社区资料是公开的。这意味着任何人都可以查看其个人资料信息，无需好友关系或特定权限。
*/
SELECT communityvisibilitystate, COUNT(*) AS count
FROM [steam].[dbo].[steam data]
GROUP BY communityvisibilitystate;  

-- 统计国籍分布情况,或许与初始点的选取以及遍历方式有关，可以看到，约41%的人不愿意透露自己的所在地信息，并且在地区设置时是随意的，因此数据并非完全准确，但仍可从国籍判断，本次数据值反应的大概率为欧美市场趋势。
/*
total 20441
Unknown	8416
FI	芬兰 1889 
US	美国 1759
SE	瑞典 1202
AU	澳大利亚 1042
GB	英国 634
*/
SELECT loccountrycode, COUNT(loccountrycode) AS count
FROM [steam].[dbo].[steam data]
GROUP BY loccountrycode
ORDER BY COUNT(*) DESC


-- 计算不同国家的游戏数量（剔除了不包含0的），
/*
BR 巴西	751	13
IE 爱尔兰	610	11
AU 澳大利亚 387	217
US 美国 367	575
CA 加拿大 363	78
VN 越南 360	7
...
average 211
*/
SELECT  loccountrycode, AVG(game_count) as average_game_count,COUNT(loccountrycode) as people_count,(SELECT AVG(game_count) FROM [steam].[dbo].[steam data] WHERE game_count > 0) AS total_average_game_count
FROM [steam].[dbo].[steam data]
WHERE (game_count>0) 
GROUP BY loccountrycode
HAVING (COUNT(loccountrycode)>4)
ORDER BY average_game_count DESC, people_count DESC
