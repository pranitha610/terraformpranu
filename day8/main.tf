module "aws" {
    source = "../day5"
    ami= "ami-0d07675d294f17973"
    instance_type = "t2.micro"
     key_name = "my_key"
  
}