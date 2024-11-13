terraform {
  backend "s3" {
    bucket = "pawanbucket2024"
    key    = "EKS/terraform.tfstate"
    region = "us-east-1"
  }
}
