-- Aggregation functions
SELECT distinct Stableisotopes FROM Elements

SELECT
	count(*) as 'Rows',
	count(Meltingpoint) as 'Values in Meltingpoint', 
	count(*) - count(Meltingpoint) as 'null-values in meltingpoint',
	count(Boilingpoint) as 'Values in Boilingpoint'
FROM
	Elements

SELECT
	count(MeltingPoint) as 'Values',
	min(Meltingpoint) as 'Lowest meltingpoint',
	max(Meltingpoint) as 'Highest meltingpoint',
	sum(Meltingpoint) as 'Sum of all meltingpoints' ,
	avg(Meltingpoint) as 'Genomsnittlig meltingpoint' ,
	min(Name) as 'ASC in alpha',
	max(Name) as 'DESC in aplha',
	string_agg(Name, ', ') as 'All names',
	count(distinct StableIsotopes)
FROM
	Elements

-- Grouping data
SELECT * FROM Elements

SELECT
	Period, 
	count(*) as 'Antal grund�mnen', 
	Min(Boilingpoint) as 'L�gst kokpunkt',
	Max(Boilingpoint) as 'H�gsta kokpunkt',
	Avg(Boilingpoint) as 'Medelkokpunkt',
	Sum(Boilingpoint) / Count(*) as 'Medel med alla null r�knat som 0'
FROM
	Elements
WHERE
	Boilingpoint < 100			-- Where => filtrering p� radniv� innan gruppering
GROUP BY
period
HAVING
	Max(Boilingpoint) < 5000    -- Having => filtrering av grupper efter gruppering

SELECT
ShipRegion, ShipCountry, ShipCity, OrderDate, ShippedDate, datediff(day, OrderDate, ShippedDate) as 'Daydiff' 
FROM company.orders ORDER BY ShipRegion, ShipCountry, ShipCity

SELECT 
	ShipRegion, 
	ShipCountry, 
	ShipCity, 
	count(*) as 'Order count', 
	Max(OrderDate) as 'Last order', 
	avg(convert(float, datediff(day, OrderDate, ShippedDate))) as 'Average days before shipping' 
FROM
	company.orders 
GROUP BY 
	ShipCity, ShipRegion, ShipCountry 
ORDER BY
	ShipRegion, ShipCountry, ShipCity