terraform {
  backend "s3" {
    bucket = "pawanbucket29jan2025"
    key    = "jenkins/terraform.tfstate"
    region = "ap-south-1"
  }
}
