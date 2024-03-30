terraform {
  backend "s3" {
    bucket = "mywishbucket021"
    key    = "local-jenkins/terraform.tfstate"
    region = "us-west-1"

  }
}