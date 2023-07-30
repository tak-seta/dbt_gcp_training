cd dbt_transform
dbt build --profiles-dir . "$@"
cd ..
