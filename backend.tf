terraform {
  backend "s3" {
    bucket = "<name>"
    key    = "msk.tfstate"
    region = "us-east-2"
  }
}