#created a targt group for alb
resource "aws_lb_target_group" "TG" {
  name        = "myTG"
  target_type = "instance"
  protocol    = "HTTP"
  port        = "80"
  vpc_id      = aws_vpc.cust.id

  protocol_version = "HTTP1"
  depends_on       = [aws_vpc.cust]
  tags = {
    Name = "myTG"
  }


}
#created a LB application load blancer and added target group to alb listener
resource "aws_lb" "name" {
  name               = "myALB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.SG.id]
  subnets            = [aws_subnet.public.id, aws_subnet.public2.id]
  depends_on         = [aws_lb_target_group.TG]
  tags = {
    Name = "myALB"
  }
}
#added target group to alb listener
resource "aws_lb_listener" "alb" {
  load_balancer_arn = aws_lb.name.arn
  protocol          = "HTTP"
  port              = "80"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.TG.arn
  }
  depends_on = [aws_lb_target_group.TG]
}