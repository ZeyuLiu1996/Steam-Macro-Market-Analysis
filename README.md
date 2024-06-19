<p align="center"><img width=70% src="./images/steamDA.jpg"></p>
<p align="center">
  <img alt="Static Badge" src="https://img.shields.io/badge/Status-Active-green">
  <img alt="Python" src="https://img.shields.io/badge/Python-v3.6%2B-blue">
  <a href="https://opensource.org/licenses/MIT">
    <img alt="Static Badge" src="https://img.shields.io/badge/License-MIT-orange">
  </a>
</p>

## Project Overview 🔬
This project aims to comprehensively understand the Steam gaming market, covering a wide range of data science technologies including **data mining, complex data querying, data cleaning, feature engineering, data analysis, machine learning, and data visualization**. The research goals are as follows:
-   Identify gaming market preferences across different countries.
-   Classify different groups of players.
-   Analyze both historically popular and currently trending games.
-   Determine the market share of different game genres.
-   Analyze the distribution of game pricing in the market.

This project is suitable for professionals in the gaming market industry, game enthusiasts, and entry-level data analysts as a reference to enrich their understanding of the gaming market and to systematically learn about the complete data science workflow. I hope this project will be helpful to you : )

## Environment Setup 🧶
- To obtain a Steam API key, please click [here](https://steamcommunity.com/dev).
- SQL Server 19
- Based on Python:
    - Pandas: Data analysis library
    - NumPy: Supports large arrays and matrix operations
    - Matplotlib: Plotting library
    - Seaborn: Advanced visualization library based on Matplotlib
    - scikit-learn: Simple and effective machine learning library
    - asyncio: Structured network programming tool
    - httpx: Structured network programming tool offering synchronous and asynchronous requests

## Summary Files 🔭
- Please refer to the Powerpoint file [Steam_DA_overview](./doc/Steam_DA_overview.pptx) for an overview of this project.


## Workflow Introduction 💻
<p align="center"><img width=100% src="./images/SteamDA_workflow.png"></p>

0. **Obtain Steam API key**: Initially, you need to obtain your own key for data fetching.
1. **Fetch player IDs**: Since there is no publicly available SteamID dataset, the first step involves fetching valid player IDs, please refer to the file👉[【Fetch IDs】](./src/1.%20data_extraction/extract_about_steam_ids/search_steamids.ipynb).
2. **Fetch player information**: Collect various related information about the player IDs mentioned above, please refer to the file👉[【Fetch Player Info】](./src/1.%20data_extraction/extract_about_steam_ids/use_steam_api.ipynb).
3. **JSON Repair**: Use the JSONchecker script to fix the fetched data, please use the file👉[【JSON Repair】](./src/3.%20data_cleaning/json_checker.ipynb)<br>
4. **Data Extraction**:
    - 4.1 **Complex Data Extraction Related to IDs**: Use pandas to query ID-related JSON files, please refer to the file👉[【Query Process】](./src/2.%20data_query/Steam_id_query_process.ipynb).
    - 4.2 **Fetch Additional Game Information**: Call the API to fetch additional information about games played by the players, please refer to the file👉[【Fetch Game Info】](./src/1.%20data_extraction/extract_about_steam_games/Steam_game_infomation_fetcher.ipynb).
    - 4.3 **JSON Repair**: Use the JSONchecker script again to fix the fetched data, please use the file👉[【JSON Repair】](./src/3.%20data_cleaning/json_checker.ipynb).
    - 4.4 **Game Data Extraction**: Use pandas to query game-related JSON files, please refer to the file👉[【Query Process】](./src/2.%20data_query/Steam_game_query_process.ipynb).
    - 4.5 **Table Organization and Merging**: Organize and merge the "ID" and "Game" related tables, please refer to the file👉[【Table Merge】](./src/2.%20data_query/Steam_id_and_game_merge_process.ipynb).
5. **Data Cleaning**: Address format issues with various types of data, please refer to the file👉[【Data Cleaning】](./src/3.%20data_cleaning/cleaning_process.ipynb).
6. **Feature Engineering and Data Analysis**: Analyze the data and add new parameters, please refer to the file👉[【Analysis Process】](./src/4.%20feature_enginering_and_data_analyze/analyze_process.ipynb).
7. **Machine Learning**: Use a combination of PCA and K-means for unsupervised learning to categorize users, please refer to the file👉[【Machine Learning】](./src/5.machine_learning/unsupervise_learning_PCA_and_KMEANS_for_player_cluster.ipynb).
8. **Data Visualization**: Visualize all the organized data, please refer to the file👉[【Visualization】](./src/6.visualization/plots.ipynb).

## Recommended Reading 🛠️
- Steam database https://steamdb.info/
- Detailed information on the Steam Web API: https://steamcommunity.com/dev
- Open-source project SteamKit: https://github.com/SteamRE/SteamKit
- Flowchart creation tool: https://lucid.app

## 项目简介 🔬
本项目以宏观理解Steam游戏市场为目的，全面涵盖数据科学的多项技术栈：**数据挖掘、复杂数据查询、数据清洗、特征工程、数据分析、机器学习、数据可视化等**，来实现下列研究目标：
-   识别不同国家游戏市场偏好
-   分类不同的玩家群体
-   分析历史热门游戏以及当下热门游戏
-   识别不同类别游戏在市场的占比
-   分析游戏市场定价分布情况

此项目适合游戏市场行业相关工作者、游戏爱好者以及数据分析入门级工作者作为简单参考，通过此项目丰富对于游戏市场的认知，并系统性了解数据科学的完整工作流程，希望此项目能对您有所帮助 : ）

## 环境配置 🧶
- Steam API key 请点击[链接](https://steamcommunity.com/dev)获取
- SQL Server 19
- 基于Python：
    - Pandas：数据分析工具库
    - NumPy：支持大量的维度数组和矩阵运算
    - Matplotlib：绘图工具
    - Seaborn：基于Matplotlib的高级可视化库
    - scikit-learn：简单有效的机器学习库
    - asyncio：结构化网络编程工具
    - httpx：结构化网络编程工具，提供同步和异步请求功能

## 总结文件🔭
- 请查阅Powerpoint文件 [Steam_DA_overview](./doc/Steam_DA_overview.pptx) 概览本项目


## 工作流程介绍 💻
<p align="center"><img width=100% src="./images/SteamDA_workflow.png"></p>

0. **获取steam API key**：首先需要获得自己的密钥来进行数据抓取
1. **获取玩家ID**：由于并无公开的SteamID数据集，因此第一步需要抓取有效的玩家ID，请参考文件👉[【获取ID】](./src/1.%20data_extraction/extract_about_steam_ids/search_steamids.ipynb)
2. **获得玩家信息**：搜集上述玩家ID的各项相关信息，请参考文件👉[【获取玩家信息】](./src/1.%20data_extraction/extract_about_steam_ids/use_steam_api.ipynb)
3. **JSON修复**：使用JSONchecker脚本修复所抓取的数据，请使用文件👉[【JSON修复】](./src/3.%20data_cleaning/json_checker.ipynb)<br>
4. **数据提取**：
    - 4.1 **ID相关复杂数据提取**：使用pandas查询ID相关的JSON文件，请参考文件👉[【查询过程】](./src/2.%20data_query/Steam_id_query_process.ipynb)
    - 4.2 **获得游戏补充信息**：调用API抓取玩家所玩过的游戏的补充信息，请参考文件👉[【获取游戏补充信息】](./src/1.%20data_extraction/extract_about_steam_games/Steam_game_infomation_fetcher.ipynb)
    - 4.3 **JSON修复**：再次使用JSONchecker脚本修复所抓取的数据，请使用文件👉[【JSON修复】](./src/3.%20data_cleaning/json_checker.ipynb)
    - 4.4 **游戏数据提取**：使用pandas查询游戏相关的JSON文件，请参考文件👉[【查询过程】](./src/2.%20data_query/Steam_game_query_process.ipynb)
    - 4.5 **表格整理与合并**: 将“ID”与“游戏”相关的两个表格进行整理与合并，请参考文件👉[【表格合并】](./src/2.%20data_query/Steam_id_and_game_merge_process.ipynb)
5. **数据清洗**：解决各类型数据的格式问题，请参考文件👉[【数据清洗】](./src/3.%20data_cleaning/cleaning_process.ipynb)
6. **特征工程与数据分析**：分析数据并添加新参数，请参考文件👉[【分析过程】](./src/4.%20feature_enginering_and_data_analyze/analyze_process.ipynb)
7. **机器学习**: 使用PCA与K-means的组合进行无监督学习，将用户进行分类，请参考文件👉[【机器学习】](./src/5.machine_learning/unsupervise_learning_PCA_and_KMEANS_for_player_cluster.ipynb)
8. **数据可视化**：将最后整理好的所有数据，进行数据的可视化，请参考文件👉[【可视化】](./src/6.visualization/plots.ipynb)


## 推荐阅读的参考资料 🛠️
- Steam database https://steamdb.info/
- Steam Web API详细资料 https://steamcommunity.com/dev
- 开源项目SteamKit https://github.com/SteamRE/SteamKit
- 流程图制作工具 https://lucid.app
