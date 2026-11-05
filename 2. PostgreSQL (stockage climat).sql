CREATE TABLE IF NOT EXISTS climat (
    id SERIAL PRIMARY KEY,
    date TIMESTAMP,
    region TEXT,
    lat FLOAT,
    lon FLOAT,
    temperature FLOAT,
    precipitation FLOAT
);
