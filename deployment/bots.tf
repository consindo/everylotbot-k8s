module "akl" {
  source   = "./cronjob"
  name     = "akl"
  account  = "everylotakl"
  db       = "everylot_akl"
  schedule = "*/20 * * * *"
}

module "wlg" {
  source   = "./cronjob"
  name     = "wlg"
  account  = "everylotwlg"
  db       = "everylot_wlg"
  schedule = "*/30 * * * *"
}
