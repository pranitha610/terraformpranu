terraform {
  backend "s3" {
    bucket = "s34343"
    key    = "dev/terraform.tfstate"
    region = "ap-south-1"
  }
}



