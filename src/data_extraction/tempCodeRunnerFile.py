import aiohttp
import asyncio
import aiofiles
import json
import pandas as pd
import gc
import get_api
import os

class SteamAPI:
    def __init__(self, api_key, steam_id, session):
        self.api_key = api_key
        self.steam_id = steam_id
        self.session = session

    async def fetch(self, url, retries=1):
        attempt = 0
        while attempt < retries:
            try:
                async with self.session.get(url) as response:
                    if response.status in [429, 500]:
                        await asyncio.sleep(2 ** attempt)  # Exponential back-off
                        attempt += 1
                        continue
                    response.raise_for_status()
                    return await response.json()
            except aiohttp.ClientResponseError as e:
                print(f"HTTP Error: {e.status} for URL: {url} - Attempt {attempt + 1}")
            except aiohttp.ClientError as e:
                print(f"Client Error: {str(e)} for URL: {url} - Attempt {attempt + 1}")
            attempt += 1
        print("Max retries exceeded for URL:", url)
        return None

    async def get_player_info(self):
        player_info_url = f"http://api.steampowered.com/ISteamUser/GetPlayerSummaries/v0002/?key={self.api_key}&steamids={self.steam_id}"
        return await self.fetch(player_info_url)

    async def get_player_games(self):
        player_games_url = f"http://api.steampowered.com/IPlayerService/GetOwnedGames/v0001/?key={self.api_key}&steamid={self.steam_id}&format=json"
        return await self.fetch(player_games_url)

    async def get_player_friends(self):
        player_friends_url = f"http://api.steampowered.com/ISteamUser/GetFriendList/v0001/?key={self.api_key}&steamid={self.steam_id}&relationship=friend"
        return await self.fetch(player_friends_url)

    async def run(self):
        return {
            'player_info': await self.get_player_info(),
            'player_games': await self.get_player_games(),
            'player_friends': await self.get_player_friends()
        }

async def save_json(filename, data):
    async with aiofiles.open(filename, 'a') as f:
        await f.write(json.dumps(data, indent=4) + ',\n')

async def handle_steam_id(api_key, steam_id, session, semaphore):
    async with semaphore:
        steam_api = SteamAPI(api_key, steam_id, session)
        result = await steam_api.run()
        return {steam_id: result}

async def process_batch(api_key, batch, session, semaphore, filename):
    tasks = [handle_steam_id(api_key, steam_id, session, semaphore) for steam_id in batch]
    results = await asyncio.gather(*tasks)
    for result in results:
        await save_json(filename, result)

async def main():
    api_key = get_api.steam_api_key
    df = pd.read_csv(r'C:\Users\55386\OneDrive\Documents\Scripts\Projects\Steam_Game_Rating_Prediction_Project\data\raw\steam_id.csv')
    steam_ids = df['steamid'].tolist()
    semaphore = asyncio.Semaphore(5)
    batch_size = 100
    filename = 'all_steam_data.json'

    # Prepare the file
    if not os.path.exists(filename):
        async with aiofiles.open(filename, 'w') as f:
            await f.write('[')  # Start of JSON array

    connector = aiohttp.TCPConnector(limit_per_host=5)
    async with aiohttp.ClientSession(connector=connector) as session:
        for i in range(0, len(steam_ids), batch_size):
            batch = steam_ids[i:i + batch_size]
            await process_batch(api_key, batch, session, semaphore, filename)
            gc.collect()

    # Close the JSON array
    async with aiofiles.open(filename, 'a') as f:
        await f.seek(-2, os.SEEK_END)  # Remove the last comma
        await f.write('\n]')  # End of JSON array

asyncio.run(main())
