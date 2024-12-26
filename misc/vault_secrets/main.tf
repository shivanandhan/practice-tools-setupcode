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

resource "vault_generic_secret" "roboshop-dev" {
  path = "${vault_mount.roboshop-dev.path}/frontend"

  data_json = <<EOT
{
  "catalogue_url": "http://catalogue-dev.kndevops72.online/",
  "cart_url":    "http://cart-dev.kndevops72.online/",
  "user_url":    "http://user-dev.kndevops72.online/",
  "shipping_url": "http://shipping-dev.kndevops72.online/",
  "payment_url":  "http://payment-dev.kndevops72.online/",

}
EOT
}