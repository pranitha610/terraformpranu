resource "aws_instance" "devvv" {
    ami= "ami-066784287e358dad1"
    instance_type = "t2.micro"
    key_name = "linux"
 }


resource "aws_s3_bucket" "east" {
    bucket = "eastwedd"
    depends_on = [ aws_instance.devvv ]
  
}

resource "aws_dynamodb_table" "dynamodb-lock" {
  name = "dynamodb"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "lockID"
    type = "S"
  }
} 