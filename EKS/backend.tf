terraform {
  backend "s3" {
    bucket = "bucket-lambda-s3-24"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
