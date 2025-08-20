output backet_info {
  value = aws_s3_bucket.example
}

output backet_info1 {
  value = aws_s3_bucket.example.arn
}

output user_info {
  value = aws_iam_user.user
}