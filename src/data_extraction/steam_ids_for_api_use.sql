DECLARE @jsonContent NVARCHAR(MAX)

SELECT @jsonContent = BulkColumn --将数据变成一大块
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_DA\data\raw\steam_datas.json', SINGLE_CLOB) AS j --这里请替换为您自己所保存的路径

SELECT DISTINCT steamid_object.[key]
FROM OPENJSON(@jsonContent) AS steamid_object --解析JSON格式