resource "kubernetes_secret" "everylot_keys" {
  metadata {
    name      = "everylot-keys"
    namespace = "everylotbot"
  }

  data = {
    "config.yaml" = var.config_yaml
  }
}

variable "config_yaml" {
  type        = "string"
  description = "YAML file with secret access keys"
  default     = ""
}
