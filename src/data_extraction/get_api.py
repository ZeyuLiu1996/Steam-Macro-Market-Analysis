import os

# 获取环境变量中的API密钥
steam_api_key = os.getenv('STEAM_API_KEY')

# 确保我们实际获取了密钥 
# if steam_api_key is not None:
#     print("API密钥已找到：", steam_api_key)
#     # 你可以在这里继续你的逻辑，比如调用API等
# else:
#     print("未找到API密钥，请确保已设置环境变量。")