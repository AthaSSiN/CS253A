import requests
import pandas as pd

url = "https://fantasy.premierleague.com/api/element-summary/"
players = {
            'Salah': 254,
            'Aguero': 268,
            'Sterling': 276,
            'Vardy' : 224,
            'Kane' : 388
}
db = {}

for p in players:
    r = requests.get(url + str(players[p]) + '/')
    db[p] = pd.DataFrame(r.json()["history_past"])
    db[p] = db[p].loc[db[p]['season_name'] >= '2014/15']
    db[p]['value'] = db[p]['total_points']/db[p]['end_cost']
    db[p]['player'] = p
    db[p]['goal_involvements'] = db[p]['goals_scored'] + db[p]['assists']
    db[p]['goal_involvements'] = db[p]['goal_involvements'].astype(int)
    db[p]['gpm'] = db[p]['goals_scored'] / db[p]['minutes'] * 90
    
df = pd.DataFrame(columns = db['Aguero'].keys())
for p in players:
    df = df.append(db[p])

df = df.sort_values('season_name')
df.to_csv("footballer_stats.csv", index = False)
