SELECT 
    e.region,
    e.date,
    e.cas,
    c.temperature,
    c.precipitation
FROM cas_epidemio e
JOIN climat c
ON e.region = c.region
AND DATE(e.date) = DATE(c.date);
