> Проект не доделан и брошен. Сраное облако Selectel не умеет надежно удалять
> ресурсы, хуже того, они потом не видны в панели управляения, но потребляют
> деньги. Резюме: пользоваться их облаком невозможно.

# OpenVPN на Selectel с помощью Terraform

## Начало

1. Установить Terraform. Например, `brew install tfenv`, `tfenv install`
2. `terraform init`
3. Создать сервисного пользователя:
   [инструкция](https://docs.selectel.ru/terraform/quickstart/#add-service-user).
   - Нужно только одно право доступа – "Администратор аккаунта"
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
