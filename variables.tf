variable "username" {}


variable "access_key" {
  default  = false
  nullable = false
}

variable "console" {
  default  = false
  nullable = false
}

variable "pgp_key" {
  default = null
}

variable "policy_statement" {
  type    = list(any)
  default = null
}

variable "policy_arns" {
  type     = set(string)
  default  = []
  nullable = false
}