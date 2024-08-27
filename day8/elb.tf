### targeted groups ----
resource "aws_lb_target_group" "tg" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.coust.id
  tags = {
    name = "tg"
  }
}

#### elb ----------
resource "aws_lb" "elb" {
  name               = "elb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [aws_subnet.private_sub.id, aws_subnet.public_sub.id]
  depends_on = [ aws_lb_target_group.tg ]
  tags = {
     name = "myelb"
  }
}
