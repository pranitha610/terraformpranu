resource "aws_instance" "dev" {

    ami="ami-0d07675d294f17973"
    instance_type = "t2.micro"
    key_name = "linux"

    tags = {
    Name = "testbackend"
  }
 }






    