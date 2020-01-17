resource "kubernetes_secret" "everylot_keys" {
  metadata {
    name      = "everylot-keys"
    namespace = "everylotbot"
  }

  data = {
    "config.yaml" = var.config_yaml
  }
}

resource "kubernetes_secret" "everylot_s3" {
  metadata {
    name      = "everylot-s3"
    namespace = "everylotbot"
  }

  data = {
    "AWS_ACCESS_KEY_ID"     = var.AWS_ACCESS_KEY_ID
    "AWS_SECRET_ACCESS_KEY" = var.AWS_SECRET_ACCESS_KEY
  }
}

variable "config_yaml" {
  type        = string
  description = "YAML file with secret access keys"
  default     = ""
}

variable "AWS_ACCESS_KEY_ID" {
  type        = string
  description = "S3 Credentials"
  default     = ""
}
variable "AWS_SECRET_ACCESS_KEY" {
  type        = string
  description = "S3 Credentials"
  default     = ""
}
