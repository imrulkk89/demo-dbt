

  create or replace view `monstercat-spotify-connector`.`test_data`.`my_second_dbt_model`
  OPTIONS()
  as -- Use the `ref` function to select from other models

select *
from `monstercat-spotify-connector`.`test_data`.`my_first_dbt_model`
where id = 1;

