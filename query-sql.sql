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

