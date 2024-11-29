resource "aws_instance" "devo" {
    ami="var.ami"
    instance_type = "var.instance_type"
    key_name = "var.key_name"
}
