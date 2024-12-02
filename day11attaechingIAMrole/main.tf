provider "aws" {
  region = "us-east-1"
}

# Step 1: Create IAM Role
resource "aws_iam_role" "ec2_role" {
  name               = "ec2_full_access_role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Principal : {
          Service : "ec2.amazonaws.com"
        }
        Action : "sts:AssumeRole"
      }
    ]
  })
}

# Step 2: Attach EC2 Full Access Policy
resource "aws_iam_role_policy_attachment" "ec2_full_access" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2FullAccess"
}

# Step 3: Create Instance Profile
resource "aws_iam_instance_profile" "ec2_profile" {
  name = "ec2_instance_profile"
  role = aws_iam_role.ec2_role.name
}

# Step 4: EC2 Instance with IAM Role Attached
resource "aws_instance" "my_instance" {
  ami             = "ami-0453ec754f44f9a4a" 
  instance_type   = "t2.micro"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  tags = {
    Name = "MyEC2Instance"
  }
}

