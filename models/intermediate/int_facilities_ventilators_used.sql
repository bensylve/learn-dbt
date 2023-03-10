with facid as 
(
    select distinct
        {{ dbt_utils.generate_surrogate_key(['facility_name','street_address']) }} as facility_id
    ,   facility_name
    from
        {{ ref('stg_healthdatagov__CovidHspDataCovDtl')}}
)
select 
    id.facility_id --this is really important
,   dtl.week_ending
,   dtl.total_ventilators
,   dtl.ventilators_used
from 
            {{ ref('stg_healthdatagov__CovidHspDataCovDtl')}} dtl
inner join  facid id 
    ON dtl.facility_name = id.facility_name