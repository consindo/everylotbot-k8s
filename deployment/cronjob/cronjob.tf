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
              args    = ["-c", "{ while true; do echo n; done | cp -i /db/*.sqlite /persistent-db; } && everylot ${var.account} /persistent-db/${var.db} --config /config/config.yaml --search-format '{address}, {city}, New Zealand'"]

              volume_mount {
                name       = "everylot-database"
                mount_path = "/persistent-db"
              }

              volume_mount {
                name       = "everylot-keys"
                mount_path = "/config"
              }
            }
            restart_policy = "Never"

            volume {
              name = "everylot-database"
              persistent_volume_claim {
                claim_name = "everylot-database"
              }
            }

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
