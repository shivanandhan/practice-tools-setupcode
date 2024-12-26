terraform {
  backend "s3" {
    bucket = "nterraform-practice"
    key    = "vault-secrets/terraform-tfstate"
    region = "us-east-1"
  }
}
provider "vault" {
  address = "http://vault-internal.kndevops72.online:8200"
  token = var.vault_token
  skip_tls_verify = true
}

variable "vault_token"{}

resource "vault_mount" "roboshop-dev" {
  path        = "roboshop-dev"
  type        = "kv"
  options     = { version = "2" }
  description = "Roboshop dev secrets"
 }

resource "vault_generic_secret" "frontend" {
  path = "${vault_mount.roboshop-dev.path}/frontend"

  data_json = <<EOT
 {
  "catalogue_url": "http://catalogue-dev.kndevops72.online/",
  "cart_url":    "http://cart-dev.kndevops72.online/",
  "user_url":    "http://user-dev.kndevops72.online/",
  "shipping_url": "http://shipping-dev.kndevops72.online/",
  "payment_url":  "http://payment-dev.kndevops72.online/"

 }
EOT
 }

resource "vault_generic_secret" "catalogue" {
  path = "${vault_mount.roboshop-dev.path}/catalogue"

  data_json = <<EOT
{
 "MONGO": "true",
 "MONGO_URL" : "mongodb://mongodb-dev.kndevops72.online:27017/catalogue"
}
EOT
}

resource "vault_generic_secret" "user" {
  path = "${vault_mount.roboshop-dev.path}/user"

  data_json = <<EOT
{
 "MONGO" : "true",
 "REDIS_URL" : "redis://redis-dev.kndevops72.online:6379",
  "MONGO_URL": "mongodb://mongodb-dev.kndevops72.online:27017/users"
}
EOT
}

resource "vault_generic_secret" "cart" {
  path = "${vault_mount.roboshop-dev.path}/cart"

  data_json = <<EOT
{
"REDIS_HOST": "redis-dev.kndevops72.online",
"CATALOGUE_HOST": "catalogue-dev.kndevops72.online"
}
EOT
}

resource "vault_generic_secret" "shipping" {
  path = "${vault_mount.roboshop-dev.path}/shipping"

  data_json = <<EOT
{
 "CART_ENDPOINT" : "cart-dev.kndevops72.online:8080",
  "DB_HOST" : "mysql-dev.kndevops72.online",
  "mysql_root_password" : "Roboshop@1"
}
EOT
}

resource "vault_generic_secret" "payment" {
  path = "${vault_mount.roboshop-dev.path}/payment"

  data_json = <<EOT
{
 "CART_HOST" : "cart-dev.kndevops72.online",
 "CART_PORT" : "8080",
 "USER_HOST" : "user-dev.kndevops72.online",
 "USER_PORT" : "8080",
 "AMQP_HOST" : "rabbitmq-dev.kndevops72.online",
 "AMQP_USER" : "roboshop",
 "AMQP_PASS" : "roboshop123"
}
EOT
}

resource "vault_generic_secret" "mysql" {
  path = "${vault_mount.roboshop-dev.path}/mysql"

  data_json = <<EOT
{
  "mysql_root_password" : "Roboshop@1"
}
EOT
}

resource "vault_generic_secret" "rabbitmq" {
  path = "${vault_mount.roboshop-dev.path}/rabbitmq"

  data_json = <<EOT
{
 "user" : "roboshop",
 "password" : "roboshop123"
}
EOT
}