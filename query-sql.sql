**How many rows?**

SELECT
	COUNT(*) as row_count
FROM jeep_renegade.jeep_data;

| row_count |
| --------- |
| 23900     |

**Showing Unique Values**

    SELECT DISTINCT
    	country
    FROM jeep_renegade.jeep_data;

| country |
| ------- |
| Unknown |
| USA     |
| Canada  |
| India   |

    SELECT DISTINCT
    	channel
    FROM jeep_renegade.jeep_data;

| channel                                  |
| ---------------------------------------- |
| Other                                    |
| Organic Search                           |
| Direct Mail                              |
| PPC                                      |
| Auto Sites (Cars.com, Car & Drive, etc.) |
| Build & Price Tool                       |


    SELECT DISTINCT
    	browser
    FROM jeep_renegade.jeep_data;

| browser           |
| ----------------- |
| Other             |
| Safari            |
| Firefox           |
| Chrome            |
| Internet Explorer |

**Group By Counts**
    WITH groupby_counts_example AS (
      SELECT	
      	new_date,
      	country,
      	visitor_type,
      	form_name,
      	form_start,
      	form_completes,
      	browser,
      	channel
      FROM jeep_renegade.jeep_data
      LIMIT 10
    )
    SELECT
    	channel,
        COUNT(*) as channel_count
    FROM groupby_counts_example
    GROUP BY channel
    ORDER BY channel_count DESC;

| channel                                  | channel_count |
| ---------------------------------------- | ------------- |
| Other                                    | 4             |
| Organic Search                           | 4             |
| Auto Sites (Cars.com, Car & Drive, etc.) | 1             |
| PPC                                      | 1             |


**Single Column Value Counts**
  
  SELECT
	country,
    COUNT(*) AS frequency
FROM jeep_renegade.jeep_data
GROUP BY country
ORDER BY frequency DESC;
  
| country | frequency |
| ------- | --------- |
| USA     | 12083     |
| Unknown | 7336      |
| Canada  | 2515      |
| India   | 1966      |

**Adding a Percentage Column**

    SELECT
    	country,
        COUNT(*) AS frequency,
        COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER () AS percentage
    FROM jeep_renegade.jeep_data
    GROUP BY country
    ORDER BY frequency DESC;

| country | frequency | percentage             |
| ------- | --------- | ---------------------- |
| USA     | 12083     | 0.50556485355648535565 |
| Unknown | 7336      | 0.30694560669456066946 |
| Canada  | 2515      | 0.10523012552301255230 |
| India   | 1966      | 0.08225941422594142259 |

--  Percentage decimal is a bit ugly --

SELECT
    	country,
        COUNT(*) AS frequency,
        ROUND(
          100 * COUNT(*)::NUMERIC / SUM(COUNT(*)) OVER (), 2
        ) AS percentage
    FROM jeep_renegade.jeep_data
    GROUP BY country
    ORDER BY frequency DESC;

| country | frequency | percentage |
| ------- | --------- | ---------- |
| USA     | 12083     | 50.56      |
| Unknown | 7336      | 30.69      |
| Canada  | 2515      | 10.52      |
| India   | 1966      | 8.23       |

/*
Multiple percentage value by 100 and round it to 1 decimal place using ROUND function
Note of the 100 * is used in the query below and notice the comma within the round brackets for the ROUND function.*/

**Counts For Multiple Column Combinations**
   
   SELECT
    	channel,
        form_name,
        COUNT(*) AS frequency
    FROM jeep_renegade.jeep_data
    GROUP BY channel, form_name
    ORDER BY frequency DESC;

| channel                                  | form_name | frequency |
| ---------------------------------------- | --------- | --------- |
| Organic Search                           | NONE      | 3173      |
| Other                                    | NONE      | 2792      |
| Organic Search                           | FORM_B    | 2227      |
| PPC                                      | NONE      | 2075      |
| Auto Sites (Cars.com, Car & Drive, etc.) | NONE      | 2027      |
| Organic Search                           | FORM_A    | 1855      |
| Other                                    | FORM_B    | 1686      |
| Other                                    | FORM_A    | 1591      |
| PPC                                      | FORM_A    | 1227      |
| Auto Sites (Cars.com, Car & Drive, etc.) | FORM_B    | 1207      |
| Auto Sites (Cars.com, Car & Drive, etc.) | FORM_A    | 1121      |
| PPC                                      | FORM_B    | 1093      |
| Build & Price Tool                       | NONE      | 546       |
| Direct Mail                              | NONE      | 528       |
| Direct Mail                              | FORM_B    | 214       |
| Build & Price Tool                       | FORM_B    | 212       |
| Build & Price Tool                       | FORM_A    | 169       |
| Direct Mail                              | FORM_A    | 157       |

**Average & Counts of form_completes by country**

    SELECT	
    	country,
        ROUND(AVG(form_completes),2) AS average,
       	COUNT(*) AS counts
    FROM jeep_renegade.jeep_data
    GROUP BY country
    ORDER BY counts;

| country | average | counts |
| ------- | ------- | ------ |
| India   | 0.26    | 1966   |
| Canada  | 0.31    | 2515   |
| Unknown | 0.84    | 7336   |
| USA     | 2.05    | 12083  |

**Mean, median, and mode of unique visitors**

    SELECT	
        PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY unique_visitors) 
        AS median_value,
        MODE() WITHIN GROUP (ORDER BY unique_visitors) AS mode_value,
        AVG(unique_visitors) AS mean_value
    FROM jeep_renegade.jeep_data;

| median_value | mode_value | mean_value          |
| ------------ | ---------- | ------------------- |
| 8            | 2          | 34.8031799163179916 |

**Min, Max & Range - form_completes**

    SELECT
      MIN(form_completes) AS minimum_value,
      MAX(form_completes) AS maximum_value,
      MAX(form_completes) - MIN(form_completes) AS range_value
    FROM jeep_renegade.jeep_data;

| minimum_value | maximum_value | range_value |
| ------------- | ------------- | ----------- |
| 0             | 54            | 54          |

**Window Fuction Multiple Calculations** 

SELECT
    	form_name,
        COUNT(*) AS frequency,
        SUM(COUNT(*)) OVER () AS total
    FROM jeep_renegade.jeep_data
    GROUP BY form_name;

| form_name | frequency | total |
| --------- | --------- | ----- |
| NONE      | 11141     | 23900 |
| FORM_A    | 6120      | 23900 |
| FORM_B    | 6639      | 23900 |

