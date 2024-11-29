output "publicip" {
    value = aws_instance.in.id
    description = "printing the public ip"
}