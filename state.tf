terraform {
  backend "s3" {
    bucket = "nterraform-practice"
    key    = "tools/terraform-tfstate"
    region = "us-east-1"
  }
}