provider "aws" {
  region = "us-west-2"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket = "demo001-random-uuid-bucket-id-result"

  tags = {
    Name        = "demo001"
    Environment = "Dev"
  }
}

# Add a bucket policy that allows public access
resource "aws_s3_bucket_policy" "public_access" {
  bucket = aws_s3_bucket.demo_bucket.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid       = "PublicReadGetObject",
        Effect    = "Allow",
        Principal = "*",
        Action    = "s3:GetObject",
        Resource  = "${aws_s3_bucket.demo_bucket.arn}/*"
      }
    ]
  })
}
