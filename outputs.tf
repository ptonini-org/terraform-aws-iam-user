output "this" {
  value = aws_iam_user.this
}

output "access_key" {
  value     = one(aws_iam_access_key.this[*])
  sensitive = true
}