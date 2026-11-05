import requests
import psycopg2
from datetime import datetime

conn = psycopg2.connect(
    dbname="epidemiologie",
    user="postgres",
    password="password",
    host="postgres"
)

cur = conn.cursor()

def get_weather(lat, lon):
    url = f"https://api.open-meteo.com/v1/forecast?latitude={lat}&longitude={lon}&current_weather=true&hourly=precipitation"
    r = requests.get(url).json()
    
    return {
        "temp": r["current_weather"]["temperature"],
        "rain": r["hourly"]["precipitation"][0]
    }

regions = [
    ("Goma", -1.6788, 29.2228),
    ("Kinshasa", -4.4419, 15.2663)
]

for region, lat, lon in regions:
    
    w = get_weather(lat, lon)
    
    cur.execute("""
        INSERT INTO climat(date, region, lat, lon, temperature, precipitation)
        VALUES (%s,%s,%s,%s,%s,%s)
    """, (
        datetime.now(),
        region,
        lat,
        lon,
        w["temp"],
        w["rain"]
    ))
    
    conn.commit()
    print("Inserted:", region)
