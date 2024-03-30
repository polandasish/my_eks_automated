terraform {
  backend "s3" {
    bucket = "myjenkinsbucketwest1"
    key    = "eks/terraform.tfstate"
    region = "us-west-1"

  }
}