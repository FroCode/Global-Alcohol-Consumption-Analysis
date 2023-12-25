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

#Questio