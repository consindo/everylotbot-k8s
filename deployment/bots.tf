module "akl" {
  source   = "./cronjob"
  name     = "akl"
  account  = "everylotakl"
  db       = "everylot_akl"
  schedule = "*/60 * * * *"
}

module "wlg" {
  source   = "./cronjob"
  name     = "wlg"
  account  = "everylotwlg"
  db       = "everylot_wlg"
  schedule = "*/60 * * * *"
  price    = " --get-price true"
}

module "chc" {
  source   = "./cronjob"
  name     = "chc"
  account  = "everylotchc"
  db       = "everylot_chc"
  schedule = "*/60 * * * *"
}

module "tokyo" {
  source   = "./cronjob"
  name     = "tokyo"
  account  = "everylottokyo"
  db       = "everylot_tokyo"
  schedule = "*/60 * * * *"
  country  = "日本"
}
