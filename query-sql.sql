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

