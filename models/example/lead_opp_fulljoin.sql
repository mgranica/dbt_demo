{{ config(materialized='table') }}

SELECT CASE
            WHEN l."ConvertedOpportunityId" IS NULL THEN 0
            ELSE 1
        END AS num_opp,
        CASE
            WHEN o."MoveInDate__c" IS NULL THEN 0
            ELSE 1
        END AS num_book,
    l."CreatedDate" AS lead_date,
    o."CreatedDate" AS opp_date,
    o."BookingDate__c" AS book_date,
    o."MoveInDate__c" AS move_date,
    o.price_eur__c AS opp_price
   FROM fa_r1_sf_lead."Lead" l
   LEFT JOIN fa_r1_sf_lead."Opportunity" o ON l."ConvertedOpportunityId" = o."Id"
   WHERE l."Email" !~~ '%movinga%'::text 
   AND l."Email" IS NOT NULL 
   AND l."Email" !~~ '%test%'::text 
   AND l."Email" !~~ '%missing%'::text 
   AND (l."Email" <> ALL (ARRAY['email@anonymized.movin.ga'::text, 'zb5cdpu4u6i=@anonymize.movin.ga'::text]));