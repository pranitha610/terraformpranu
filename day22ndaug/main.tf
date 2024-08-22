#create vpc
resource "aws_vpc" "coust" {
    cidr_block = "10.0.0.0/24"
    tags = {
      name="vpc"
    }  
}

#creation of internet gateway
resource "aws_internet_gateway" "name" {
    vpc_id = aws_vpc.coust.id
    tags = {
      name="ig"
    }
    
}
#create subnets 
resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.coust.id
    cidr_block = "10.0.0.0/16"
    tags = {
      name="sub_1"
    }
  }
  #create subnet2

  resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.coust.id
    cidr_block = "10.0.0.0/21"
    tags = {
      name="sub_2"
    }
  }
# create route table and attach to ig
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.coust.id
route {
    gateway_id = aws_internet_gateway.name.id
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng.id
    carrier_gateway_id = "0.0.0.0/8"
}    
 
}
  
#create natgateway
resource "aws_nat_gateway" "ng" {
    subnet_id = aws_subnet.private_sub.id
    allocation_id = aws_subnet.private_sub.id
  tags = {
    names = "natgate"
  }
}

#subnet association and sub inti rt
resource "aws_route_table_association" "asso" {
    route_table_id = aws_route_table.name.id
    subnet_id = aws_subnet.public_sub.id 
 
}

# create security groups
resource "aws_security_group" "traffic" {
    name = "traffic"
    vpc_id = aws_vpc.coust.id
    tags = {
      name = "sg"
    }
ingress {
    description      = "TLS from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
}
egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }  
}

#ec2 instance 

resource "aws_instance" "in" {
    ami = "var.ami"
    instance_type = "var.instance_type"
    key_name = "var.key_name"
    vpc_security_group_ids = [aws_security_group.traffic.id]
    subnet_id = aws_subnet.public_sub.id
    tags = {
      name = "my_instance"
    }
      
}
      
