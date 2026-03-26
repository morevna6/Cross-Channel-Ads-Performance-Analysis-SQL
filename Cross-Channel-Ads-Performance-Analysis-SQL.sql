with unified_ads as (
    select
        ad_date,
        'Facebook Ads' as media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    from facebook_ads_basic_daily
    where ad_date is not null

    union all

    select
        ad_date,
        'Google Ads' as media_source,
        spend,
        impressions,
        reach,
        clicks,
        leads,
        value
    from google_ads_basic_daily
    where ad_date is not null
)
select
    ad_date,
    media_source,
    SUM(spend)       as total_spend,
    SUM(impressions) as total_impressions,
    SUM(clicks)      as total_clicks,
    SUM(value)       as total_value
from unified_ads
group by ad_date, media_source
order by ad_date DESC, media_source;
