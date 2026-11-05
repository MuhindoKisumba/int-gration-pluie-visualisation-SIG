from kafka import KafkaProducer
import json, time, random

producer = KafkaProducer(
    bootstrap_servers='kafka:9092',
    value_serializer=lambda v: json.dumps(v).encode('utf-8')
)

while True:
    data = {
        "region": "Goma",
        "temperature": random.uniform(20, 30),
        "rain": random.uniform(0, 10)
    }
    
    producer.send("climat", data)
    time.sleep(5)
