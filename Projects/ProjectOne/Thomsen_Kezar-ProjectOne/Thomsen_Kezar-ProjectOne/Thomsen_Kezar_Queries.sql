use all_burl_properties;
SELECT
    pa.st_name AS StreetName,
    p.b_type AS PropertyType,
    COUNT(*) AS PropertyCount
FROM
    property p
JOIN
    propertyaddress pa ON p.prop_id = pa.prop_id
GROUP BY
    pa.st_name, p.b_type
ORDER BY
    pa.st_name, PropertyCount DESC;

/* Sorts every street Alphabetically, and sorts the Property Type in DESC order by how many Properties of that Type exist on that Street */


SELECT
    pa.st_name AS StreetName,
    GROUP_CONCAT(pa.st_num ORDER BY pa.st_num) AS CombinedStreetNumbers,
    l.land_use AS LandUse,
    SUM(pv.total_value) AS TotalValue
FROM
    property p
JOIN
    propertyaddress pa ON p.prop_id = pa.prop_id
JOIN
    propertyvalue pv ON p.prop_id = pv.prop_id
JOIN
land l ON p.prop_id = l.prop_id
GROUP BY
    pa.st_name, l.land_use
ORDER BY
    pa.st_name, TotalValue DESC;

/* Combines any street number that uses the same Land Use, and grabs the Sum of the houses per Land Use. Sorts Streets by Alphabetical, and Total Value DESC */


SELECT
    pa.st_name AS StreetName,
    pa.st_num AS StreetNumber,
    p.b_type AS PropertyType,
    pv.total_value AS TotalValue
FROM
    property p
JOIN
    propertyaddress pa ON p.prop_id = pa.prop_id
JOIN
	propertyvalue pv ON p.prop_id = pv.prop_id
GROUP BY
    pa.st_name, pa.st_num, p.b_type, pv.total_value
ORDER BY
    pa.st_name, pv.total_value DESC;


/* Sorts every street Alphabetically, and lists house type and house value (DESC) per street */



SELECT
    pa.st_name AS StreetName,
    GROUP_CONCAT(pa.st_num ORDER BY pa.st_num) AS CombinedStreetNumbers,
    SUM(pv.total_value) AS TotalValue
FROM
    property p
JOIN
    propertyaddress pa ON p.prop_id = pa.prop_id
JOIN
    propertyvalue pv ON p.prop_id = pv.prop_id
GROUP BY
    pa.st_name
ORDER BY
    pa.st_name, TotalValue DESC;

/* Average the total_value as a new column and map the land usage to the average price of the property that it is used.  */


SELECT
    LU.land_use,
    CONVERT(AVG(PV.total_value), DECIMAL(10, 2)) AS avg_property_value_rounded,
    pa.st_name AS StreetName
FROM
    land LU
JOIN
    propertyvalue PV ON LU.prop_id = PV.prop_id
JOIN
    property p ON LU.prop_id = p.prop_id
JOIN
    propertyaddress pa ON p.prop_id = pa.prop_id
GROUP BY
    LU.land_use, pa.st_name
ORDER BY
    avg_property_value_rounded DESC, StreetName;
    
/*Returns the Land usage, as well as the average property value and the street that is using that land.
 This shows where land is more expensive and shows how where and what it is used for changes the price.*/

