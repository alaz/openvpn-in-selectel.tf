# OpenVPN на Selectel с помощью Terraform

## Начало

1. Установить Terraform. Например, `brew install tfenv`, `tfenv install`
2. `terraform init`
3. Создать сервисного пользователя:
   [инструкция](https://docs.selectel.ru/terraform/quickstart/#add-service-user)
4. Заполнить переменные в `terraform.tfvars`

## Создать OpenVPN сервер

```
terraform plan
terraform apply
```

## Удалить всю созданную инфраструктуру

```
terraform destroy
```
