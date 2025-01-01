module "policy" {
  source    = "app.terraform.io/linxsa/iam-policy/aws"
  version   = "~> 1.0.0"
  statement = var.policy_statement
}

resource "aws_iam_user" "this" {
  name = var.username
  path = "/"
}

resource "aws_iam_access_key" "this" {
  count = var.access_key ? 1 : 0
  user  = aws_iam_user.this.name
}

resource "aws_iam_user_policy" "this" {
  count  = var.policy_statement == null ? 0 : 1
  user   = aws_iam_user.this.name
  policy = module.policy.json_statement
}

resource "aws_iam_user_policy_attachment" "this" {
  for_each   = var.policy_arns
  policy_arn = each.value
  user       = aws_iam_user.this.name
}