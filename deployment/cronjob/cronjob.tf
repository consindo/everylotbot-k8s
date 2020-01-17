variable "name" {
  type        = string
  description = "name of cronjob"
}

variable "account" {
  type        = string
  description = "account defined in config.yaml"
}

variable "db" {
  type        = string
  description = "path to db"
}

variable "schedule" {
  type        = string
  description = "crontab"
  default     = "* */1 * * *"
}

variable "s3_host" {
  type        = string
  description = "hostname for s3 bucket"
  default     = "--host=sfo2.digitaloceanspaces.com  --host-bucket='%(bucket)s.sfo2.digitaloceanspaces.com'"
}

variable "bucket" {
  type        = string
  description = "s3 bucket name"
  default     = "s3://everylotbot"
}

resource "kubernetes_cron_job" "everylotbot" {
  metadata {
    name      = var.name
    namespace = "everylotbot"
  }
  spec {
    schedule = var.schedule
    job_template {
      metadata {}
      spec {
        template {
          metadata {
            labels = {
              app = "everylotbot"
            }
          }
          spec {
            container {
              name    = "everylotbot"
              image   = "consindo/everylotbot:latest"
              command = ["/bin/sh"]
              args    = ["-c", "mkdir /tmp-db && cd /tmp-db && s3cmd ${var.s3_host} get ${var.bucket}/${var.db}.tar.gz && tar -xzf /tmp-db/*.tar.gz && everylot ${var.account} /tmp-db/${var.db}.sqlite --config /config/config.yaml --search-format '{address}, {city}, New Zealand' && tar -czf ${var.db}.tar.gz ${var.db}.sqlite && s3cmd ${var.s3_host} put ${var.db}.tar.gz ${var.bucket}"]

              env {
                name = "AWS_ACCESS_KEY_ID"
                value_from {
                  secret_key_ref {
                    name = "everylot-s3"
                    key  = "AWS_ACCESS_KEY_ID"
                  }
                }
              }

              env {
                name = "AWS_SECRET_ACCESS_KEY"
                value_from {
                  secret_key_ref {
                    name = "everylot-s3"
                    key  = "AWS_SECRET_ACCESS_KEY"
                  }
                }
              }

              volume_mount {
                name       = "everylot-keys"
                mount_path = "/config"
              }
            }
            restart_policy = "Never"

            volume {
              name = "everylot-keys"
              secret {
                secret_name = "everylot-keys"
              }
            }
          }
        }
      }
    }
  }
}
