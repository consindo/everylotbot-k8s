module "akl" {
  source   = "./cronjob"
  name     = "akl"
  account  = "everylotakl"
  db       = "everylot_akl"
  schedule = "*/20 * * * *"
}
