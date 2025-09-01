terraform {
  backend "s3" {
    bucket = "eldiiar-bucket"
    key    = "terraform.tfstate"
    region = "us-east-2"
    dynamodb_table = "lock-state"
  }
}
