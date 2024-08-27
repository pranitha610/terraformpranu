### -----------creation of vpc ----------##
resource "aws_vpc" "coust" {
    cidr_block = "10.0.0.0/24"
    tags = {
      name="vpc"
    }  
}

### --------------------creation of subnets ------------##
resource "aws_subnet" "public_sub" {
    vpc_id = aws_vpc.coust.id
    cidr_block = "10.0.0.0/28"
    availability_zone = "ap-south-1b"
    depends_on = [aws_vpc.coust]

    tags = {
      name="sub_1"
    }
  }
###------------------subnet2-------------------------##
resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.coust.id
    cidr_block = "10.0.0.192/27"
    availability_zone = "ap-south-1a"
    depends_on = [aws_vpc.coust]

    tags = {
      name="sub_2"
    }
  }  



#### -----------------creation of internat gateways-----
resource "aws_internet_gateway" "ig" {
        vpc_id = aws_vpc.coust.id
        depends_on = [aws_vpc.coust]

    tags = {
      name="ig"
    }
}

##---------------# create route table and attach to ig
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.coust.id
route {
    gateway_id = aws_internet_gateway.ig.id
    cidr_block = "0.0.0.0/0"
    
}  
} 
 

## -----------creation of instance------------
resource "aws_instance" "web" {
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name = "sid"
    vpc_security_group_ids = [aws_security_group.sg.id]
        tags = {
      name = "web"
    }
  
}

#### -----------------creating security grp -----------#
resource "aws_security_group" "sg" {
    name = "sg"
    depends_on = [ aws_vpc.coust ]
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

ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    
  }  
}