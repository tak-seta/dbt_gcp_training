terraform実行順序
```
terraform init
op run --env-file=1password.env -- terraform plan
op run --env-file=1password.env -- terraform apply
```
