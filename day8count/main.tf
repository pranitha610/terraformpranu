resource "aws_instance" "devo" {
      ami="ami-01fb4de0e9f8f22a7 "
    instance_type = "t2.micro"
    key_name = "prani"
    count = length(var.test)
  
}


 variable "test" {
    type = list(string)
    default = [ "web","sub","ig","ins" ]
   
 }