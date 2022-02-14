{{ config(
    indexes = [{'columns':['_airbyte_emitted_at'],'type':'btree'}],
    unique_key = '_airbyte_ab_id',
    schema = "_airbyte_public",
    tags = [ "top-level-intermediate" ]
) }}
-- SQL model to build a hash column based on the values of this record
-- depends_on: {{ ref('covid_epidemiology_ab2') }}
select
    {{ dbt_utils.surrogate_key([
        adapter.quote('key'),
        adapter.quote('date'),
        'new_tested',
        'new_deceased',
        'total_tested',
        'new_confirmed',
        'new_recovered',
        'total_deceased',
        'total_confirmed',
        'total_recovered',
    ]) }} as _airbyte_covid_epidemiology_hashid,
    tmp.*
from {{ ref('covid_epidemiology_ab2') }} tmp
-- covid_epidemiology
where 1 = 1
{{ incremental_clause('_airbyte_emitted_at') }}

