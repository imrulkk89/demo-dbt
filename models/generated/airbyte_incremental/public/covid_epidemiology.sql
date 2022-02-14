{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "public",
    tags = [ "top-level" ]
) }}
-- Final base SQL model
-- depends_on: {{ ref('covid_epidemiology_ab3') }}
select
    {{ adapter.quote('key') }},
    {{ adapter.quote('date') }} as date,
    new_tested,
    new_deceased,
    total_tested,
    new_confirmed,
    new_recovered,
    total_deceased,
    total_confirmed,
    total_recovered,
    _airbyte_ab_id,
    _airbyte_emitted_at,
    {{ current_timestamp() }} as _airbyte_normalized_at,
    _airbyte_covid_epidemiology_hashid
from {{ ref('covid_epidemiology_ab3') }}
-- covid_epidemiology from {{ source('public', '_airbyte_raw_covid_epidemiology') }}
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}
order by date asc;

