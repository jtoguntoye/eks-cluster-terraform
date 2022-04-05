provider "aws" {
    region = var.region
}

terraform {
  backend "s3" {
      bucket = "city-allies-site"
      key = "s3/terraform.tfstate"
      region = "eu-west-3"
  }
}