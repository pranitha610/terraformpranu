provider "aws" {
  region = "us-east-1"
}

# Step 1: Create an S3 Bucket 
resource "aws_s3_bucket" "pranitha123" {
    bucket = "rajee12345678"
    tags = {
    Name        = "rajee12345678"
    Environment = "Dev"
  }
}

# Upload Files to the S3 Bucket
resource "aws_s3_object" "uploaded_file" {
  bucket = aws_s3_bucket.pranitha123.bucket           # Replace with your bucket name if already created
  key    = "folder/file1"                               # Path in the bucket where the file will be stored
  source = "c:/Users/SIDDAVATAM PRANITHA/OneDrive/Desktop/Terr.docx"                   # Path to the local file to upload
  acl    = "private"                        # Set object access control
}