
#create vpc for alb
resource "aws_vpc" "cust" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "myvpc"
  }

}
#internet gateway need to create for vpc to external commmunication and attach to vpc 
resource "aws_internet_gateway" "IG" {
  vpc_id = aws_vpc.cust.id
  tags = {
    Name = "myIG"
  }
  depends_on = [aws_vpc.cust]

}
# for alb we need public subnet to connect external communication like clinet and we need to avaliabality zone tor mapping 
resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.cust.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
  depends_on = [aws_vpc.cust]
}

resource "aws_subnet" "public2" {
  vpc_id            = aws_vpc.cust.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "publicsubnet-2"
  }
  depends_on = [aws_subnet.public]
}

#security group for alb
resource "aws_security_group" "SG" {
  name       = "alb-sg"
  vpc_id     = aws_vpc.cust.id
  depends_on = [aws_vpc.cust]


  ingress {
    description = "http"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "https"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}