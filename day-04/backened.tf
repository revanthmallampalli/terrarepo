terraform {
  backend "s3" {
    bucket = "revanth-s3-demo-xyz"
    key    = "revanth/terraform.tfstate"
    region = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock"
  }
}
