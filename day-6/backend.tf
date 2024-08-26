terraform {
  backend "s3" {
    bucket = "prani"
    key    = "singapore/terraform.tfstate"
    region = "ap-southeast-1"
    dynamodb_table = "terraform-state-lock-dynamo" 
       encrypt = "true"
      }
}