resource "aws_instance" "name" {
    ami= "ami-025258b26b492aec6"
    instance_type = "t2.micro"
    key_name = "webb"
    tags = {
    Name = "testbackend"
  }

 }
 
