resource "aws_instance" "sid" {
    ami= "ami-0c6359fd9eb30edcf"
    instance_type = "t2.micro"
    key_name = "singapore"
    tags = {
    Name = "testbackend"
  }
}
resource "null_resource" "run_script" {
  provisioner "local-exec" {
    command = "${path.module}/hello.sh"
  }

  depends_on = [aws_instance.sid]
}
