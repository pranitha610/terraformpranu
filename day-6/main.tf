resource "aws_instance" "dev" {
    ami= "ami-0d07675d294f17973"
    instance_type = "t2.micro"
    key_name = "singapore"
 }

 resource "aws_s3_bucket" "name" {
    bucket="prani"
   tags = {
    Name = "prani"
  }
}


 #-------Locking provision for statefile -------------------#
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}