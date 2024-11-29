<<<<<<< HEAD
resource "aws_instance" "devo" {
    ami="var.ami"
    instance_type = "var.instance_type"
    key_name = "var.key_name"
}
=======
resource "aws_instance" "name" {
    ami= "ami-04a5ce820a419d6da"
    instance_type = "t2.micro"
    key_name = "my_key"
    tags = {
    Name = "testbackend"
  }

 }
 
>>>>>>> 056b407d0242c835510cdd77085943eb24e7fabd
