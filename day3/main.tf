resource "aws_instance" "name" {
    ami= "ami-0e53db6fd757e38c7"
    instance_type = "t2.micro"
    key_name = "linux"
    tags = {
    Name = "testbackend"
  }

 }
 
