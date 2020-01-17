resource "kubernetes_persistent_volume_claim" "everylot_database" {
  metadata {
    name      = "everylot-database"
    namespace = "everylotbot"
  }
  spec {
    access_modes = ["ReadWriteOnce"]
    resources {
      requests = {
        storage = "1Gi"
      }
    }
    storage_class_name = "do-block-storage"
  }
}
