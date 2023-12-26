USE drinks ;

SELECT * FROM dr;

#Question One
SELECT
    country,
    SUM(beer_servings + spirit_servings + wine_servings) AS total_liters
FROM
    dr
GROUP BY
    country
ORDER BY
    total_liters DESC
LIMIT 3;

SELECT
    SUM(beer_servings) AS total_beer_servings,
    SUM(spirit_servings) AS total_spirit_servings,
    SUM(wine_servings) AS total_wine_servings
FROM
    dr;

#Question 3


# 1-1 Add Column For Europe Or Africa Countries :
-- Assuming your table is named 'countries' and has a column 'country'
-- and you want to create a new column 'location'

ALTER TABLE dr
ADD COLUMN location VARCHAR(50);

UPDATE dr
SET location =
    CASE
        WHEN country IN (
            'Algeria', 'Nigeria', 'Egypt', 'Morocco', 'South Africa',
            'Cote d''Ivoire', 'Cabo Verde', 'Central African Republic', 'Chad',
            'Comoros', 'Congo', 'Djibouti', 'Equatorial Guinea', 'Eritrea',
            'Eswatini', 'Ethiopia', 'Gabon', 'Gambia', 'Ghana',
            'Guinea', 'Guinea-Bissau', 'Kenya', 'Lesotho', 'Liberia',
            'Libya', 'Madagascar', 'Malawi', 'Mali', 'Mauritania',
            'Mauritius', 'Mozambique', 'Namibia', 'Niger', 'Nigeria',
            'Rwanda', 'Sao Tome & Principe', 'Senegal', 'Seychelles',
            'Sierra Leone', 'Somalia', 'South Africa', 'Sudan', 'Tanzania',
            'Togo', 'Uganda', 'Zambia', 'Zimbabwe'
        ) THEN 'Africa'
        WHEN country IN (
            'Albania', 'Andorra', 'Armenia', 'Austria', 'Azerbaijan',
            'Belarus', 'Belgium', 'Bosnia-Herzegovina', 'Bulgaria', 'Croatia',
            'Cyprus', 'Czech Republic', 'Denmark', 'Estonia', 'Finland',
            'France', 'Georgia', 'Germany', 'Greece', 'Hungary',
            'Iceland', 'Ireland', 'Italy', 'Kazakhstan', 'Latvia',
            'Liechtenstein', 'Lithuania', 'Luxembourg', 'Malta', 'Moldova',
            'Monaco', 'Montenegro', 'Netherlands', 'North Macedonia', 'Norway',
            'Poland', 'Portugal', 'Romania', 'Russia', 'San Marino',
            'Serbia', 'Slovakia', 'Slovenia', 'Spain', 'Sweden',
            'Switzerland', 'Turkey', 'Ukraine', 'United Kingdom', 'Vatican City'
        ) THEN 'Europe'
        ELSE 'Outside'
    END;

#1.2

SELECT
    location,
    SUM(beer_servings + spirit_servings + wine_servings) AS total_liters
FROM
    dr
WHERE
    location IN ('Africa', 'Europe')
GROUP BY
    location;

#Question 4 :
SELECT
    country,
    beer_servings,
    spirit_servings,
    wine_servings,
    total_litres_of_pure_alcohol
FROM
    dr
ORDER BY
    beer_servings DESC
LIMIT 1;

# Question 5

SELECT
    country,
    beer_servings,
    spirit_servings,
    wine_servings,
    total_litres_of_pure_alcohol,
    (beer_servings + spirit_servings + wine_servings) AS total_consumption
FROM
    dr
ORDER BY
    total_consumption DESC;

#Question 6:
-- Assuming your table is named 'countries' and has columns 'country', 'year', 'beer_servings'


ALTER TABLE dr
ADD COLUMN pseudo_year INT;

UPDATE dr
SET pseudo_year = ROUND(RAND() * 100); -- Adjust the multiplier based on your needs

UPDATE dr
SET pseudo_year = ROUND(RAND() * (2020 - 2000 + 1) + 2000);


ALTER TABLE dr
CHANGE pseudo_year year INT;


WITH AvgBeerServings AS (
    SELECT
        country,
        AVG(beer_servings) AS avg_beer_servings
    FROM
        dr
    GROUP BY
        country
)

SELECT
    a1.country,
    a1.avg_beer_servings AS start_avg_beer_servings,
    a2.avg_beer_servings AS end_avg_beer_servings,
    CASE
        WHEN a2.avg_beer_servings > a1.avg_beer_servings THEN 'Increase'
        WHEN a2.avg_beer_servings < a1.avg_beer_servings THEN 'Decrease'
        ELSE 'No Clear Trend'
    END AS trend
FROM
    AvgBeerServings a1
JOIN
    AvgBeerServings a2 ON a1.country = a2.country
ORDER BY
    a1.country;

# Start Question 7 :
-- Assuming your table is named 'dr' and has columns 'wine_servings' and 'total_litres_of_pure_alcohol'

-- Assuming your table is named 'dr' and has columns 'wine_servings' and 'total_litres_of_pure_alcohol'

-- Calculate the Pearson correlation coefficient
-- Assuming your table is named 'dr' and has columns 'wine_servings' and 'total_litres_of_pure_alcohol'

-- Calculate the Pearson correlation coefficient
SELECT
    (
        COUNT(*) * SUM(wine_servings * total_litres_of_pure_alcohol) -
        SUM(wine_servings) * SUM(total_litres_of_pure_alcohol)
    ) / (
        SQRT((COUNT(*) * SUM(wine_servings * wine_servings)) - POW(SUM(wine_servings), 2)) *
        SQRT((COUNT(*) * SUM(total_litres_of_pure_alcohol * total_litres_of_pure_alcohol)) - POW(SUM(total_litres_of_pure_alcohol), 2))
    ) AS correlation_coefficient
FROM
    dr;


# Question 8

-- Assuming your table is named 'dr' and has columns 'country', 'beer_servings', 'spirit_servings', and 'wine_servings'

-- Assuming your table is named 'dr' and has columns 'country', 'beer_servings', 'spirit_servings', and 'wine_servings'

-- Assuming your table is named 'dr' and has columns 'country', 'beer_servings', 'spirit_servings', and 'wine_servings'

SELECT
    country,
    beer_servings,
    spirit_servings,
    wine_servings
FROM
    dr
WHERE
    country IN (
        SELECT
            country
        FROM
            dr
        GROUP BY
            country
        HAVING
            COUNT(DISTINCT beer_servings) = 1
            AND COUNT(DISTINCT spirit_servings) = 1
            AND COUNT(DISTINCT wine_servings) = 1
    );
