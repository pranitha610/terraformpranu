resource "aws_iam_role" "my_role" {
  name               = "my_custom_role"
  assume_role_policy = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Principal : {
          Service : [
            "lambda.amazonaws.com",
            "ec2.amazonaws.com"
          ]
        }
        Action : "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_policy" "s3_policy" {
  name        = "S3AccessPolicy"
  description = "Policy to allow S3 bucket access"
  policy      = jsonencode({
    Version : "2012-10-17"
    Statement : [
      {
        Effect : "Allow"
        Action : [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Resource : [
          "arn:aws:s3:::my-bucket-name",
          "arn:aws:s3:::my-bucket-name/*"
        ]
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "s3_attachment" {
  role       = aws_iam_role.my_role.name
  policy_arn = aws_iam_policy.s3_policy.arn
}

output "role_arn" {
  value = aws_iam_role.my_role.arn
  description = "The ARN of the IAM role"
}
