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
