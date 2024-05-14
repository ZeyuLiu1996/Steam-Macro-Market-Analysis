DECLARE @jsonContent NVARCHAR(MAX);

SELECT @jsonContent = BulkColumn
FROM OPENROWSET (BULK 'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_DA\data\raw\test.json', SINGLE_CLOB) AS j;

-- 解析外部数组
SELECT 
   *
FROM 
    OPENJSON(@jsonContent) AS outerArray

