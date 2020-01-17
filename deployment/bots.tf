module "akl" {
  source   = "./cronjob"
  name     = "akl"
  account  = "everylotakl"
  db       = "everylot_akl.sqlite"
  schedule = "*/30 * * * *"
}
