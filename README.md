# Cross-Channel Ads Performance Analysis (SQL)

## Project Overview
This project analyzes advertising performance across multiple channels by combining Facebook Ads and Google Ads data into one unified dataset using SQL.

The goal is to compare channel-level performance over time and create a consistent structure for marketing analysis.

---

## Datasets
- `facebook_ads_basic_daily`
- `google_ads_basic_daily`

---

## Analysis Tasks

### 1. Data Unification
A Common Table Expression (CTE) is used to combine Facebook Ads and Google Ads data into a single table with a shared structure.

### 2. Cross-Channel Aggregation
After unifying the sources, the query calculates:

- Total spend
- Total impressions
- Total clicks
- Total conversion value

grouped by:
- ad date
- media source

---

## Tools Used
- PostgreSQL
- DBeaver

---

## SQL Query

```sql
WITH unified_ads AS (
    SELECT
        ad_date,
        'Facebook Ads' AS media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM facebook_ads_basic_daily
    WHERE ad_date IS NOT NULL

    UNION ALL

    SELECT
        ad_date,
        'Google Ads' AS media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    FROM google_ads_basic_daily
    WHERE ad_date IS NOT NULL
)
SELECT
    ad_date,
    media_source,
    SUM(spend)       AS total_spend,
    SUM(impressions) AS total_impressions,
    SUM(clicks)      AS total_clicks,
    SUM(value)       AS total_value
FROM unified_ads
GROUP BY ad_date, media_source
ORDER BY ad_date DESC, media_source;
