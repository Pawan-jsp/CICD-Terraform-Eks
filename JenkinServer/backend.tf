terraform {
  backend "s3" {
    bucket = "pawanbucket2024"
    key    = "jenkins/terraform.tfstate"
    region = "us-east-1"
  }
}
