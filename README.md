## 项目简介 🔬
这是一篇关于steam数据科学的研究项目，用于宏观概览市场趋势，发现当下热门游戏类型、玩家潜在消费潜力等，项目总结请您参考文件👉[【项目总结】](notebooks/Steam_DA_overview.ipynb)；技术细节讲解请您参考文件👉[【技术细节】](notebooks/technical_detail.ipynb)
## 项目语言 🔧
- SQL Server
- Python（本地使用3.11）

## 环境配置 🧶
- Steam API key 请点击[链接](https://steamcommunity.com/dev)获取
- NVIDIA CUDA Toolkit
- 基于Python：
    - Pandas
    - NumPy 
    - Matplotlib/Seaborn
    - scikit-learn
    - asyncio
    - aiohttp

## 工具应用及参考资料 🛠️
- Steam Web API https://steamcommunity.com/dev
- 开源项目SteamKit https://github.com/SteamRE/SteamKit

## 工作流程与代码 💻
1. **获取玩家ID**：由于并无公开SteamID数据集，因此第一步需要抓取玩家的ID，请参考文件👉[【获取ID】](src/data_extraction/search_steamids.ipynb)
2. **将获取的ID经SQL整理成CSV格式供调用API**：⏰请注意替换SQL代码中的路径位置为您所实际保存的文件位置👉[【SQL代码】](src/data_extraction/steam_ids_for_api_use.sql)；查询后的ID信息请参考文件👉[【ID合集】](data\raw\ids_for_api_use.csv)
3. **调用API获取数据**：代码请参考文件👉[【调用API】](src/data_extraction/use_steam_api.ipynb)；API功能合集表请参考文件👉[【API合集】](data/processed/pandastest.ipynb)
4. **JSON文件的SQL查询**：基于SQL Server构建动态SQL语句，代码请参考文件👉[【SQL查询】](src/data_extraction/Query_processing.sql)
5. **Pandas数据清洗及分析**：请参考文件👉[【数据清洗及分析】](src/data_processing_analysis/process_analysis.ipynb)
6. **机器学习模型**： 将数据进行训练，进行用户分类识别，请参考文件👉[【机器学习模型】](src/data_processing_analysis/process_analysis.ipynb)
7. **数据可视化**： 请参考文件👉[【可视化】](src/data_visualization/visualizations.ipynb)
