data "aws_iam_policy_document" "this" {
  version = var.api_version

  dynamic "statement" {
    for_each = { for i, v in var.statement : i => v }
    content {
      sid           = coalesce(statement.value.sid, statement.key)
      effect        = statement.value.effect
      actions       = statement.value.actions
      not_actions   = statement.value.not_actions
      resources     = statement.value.resources
      not_resources = statement.value.not_resources

      dynamic "principals" {
        for_each = { for i, v in statement.value.principals : i => v }
        content {
          type        = principals.value.type
          identifiers = principals.value.identifiers
        }
      }

      dynamic "not_principals" {
        for_each = { for i, v in statement.value.not_principals : i => v }
        content {
          type        = not_principals.value.type
          identifiers = not_principals.value.identifiers
        }
      }

      dynamic "condition" {
        for_each = { for i, v in statement.value.conditions : i => v }
        content {
          test     = condition.value.test
          variable = condition.value.varialbe
          values   = condition.value.values
        }
      }
    }
  }
}

resource "aws_iam_policy" "this" {
  count  = var.name == null ? 0 : 1
  name   = var.name
  policy = data.aws_iam_policy_document.this.json

  lifecycle {
    ignore_changes = [
      tags["business_unit"],
      tags["product"],
      tags["env"],
    ]
  }
}
