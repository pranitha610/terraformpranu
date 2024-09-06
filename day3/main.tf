resource "aws_instance" "name" {
    ami= "ami-04a5ce820a419d6da"
    instance_type = "t2.micro"
    key_name = "my_key"
    tags = {
    Name = "testbackend"
  }

 }
 
