variable "name" {
  default = null
}

variable "api_version" {
  default = null
}

variable "statement" {
  type = list(object({
    sid           = optional(string)
    effect        = optional(string)
    actions       = optional(set(string))
    not_actions   = optional(set(string))
    resources     = optional(set(string))
    not_resources = optional(set(string))
    principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    not_principals = optional(list(object({
      type        = string
      identifiers = list(string)
    })), [])
    conditions = optional(list(object({
      test     = string
      variable = string
      values   = set(string)
    })), [])
  }))
  default = []
}