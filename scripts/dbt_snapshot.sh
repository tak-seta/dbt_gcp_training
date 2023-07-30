cd dbt_transform
dbt snapshot --profiles-dir . "$@"
cd ..
