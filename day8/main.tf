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
    tags = {
      name="sub_1"
    }
  }
###------------------subnet2-------------------------##
resource "aws_subnet" "private_sub" {
    vpc_id = aws_vpc.coust.id
    cidr_block = "10.0.0.192/27"
    tags = {
      name="sub_2"
    }
  }  

###--------------elastic ip allocation ---------------
resource "aws_eip" "elastic" {
    instance = aws_instance.web.id
    domain   = "vpc"
}

#### -----------------creation of internat gateways-----
resource "aws_internet_gateway" "ig" {
        vpc_id = aws_vpc.coust.id

    tags = {
      name="ig"
    }
}
#### -----------------nat gateway---------------
resource "aws_nat_gateway" "ng" {
    subnet_id = aws_subnet.public_sub.id
    allocation_id = aws_eip.elastic.id
  tags = {
    names = "natgate"
  }
}

##---------------# create route table and attach to ig
resource "aws_route_table" "name" {
    vpc_id = aws_vpc.coust.id
route {
    gateway_id = aws_internet_gateway.ig.id
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.ng.id
    carrier_gateway_id = "0.0.0.0/8"
     } 
}   
 

## -----------creation of instance------------
resource "aws_instance" "web" {
    ami = "ami-02b49a24cfb95941c"
    instance_type = "t2.micro"
    key_name = "sid"
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.public_sub.id
        tags = {
      name = "web"
    }
  
}

#### -----------------creating security grp -----------#
resource "aws_security_group" "sg" {
    name = "sg"
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