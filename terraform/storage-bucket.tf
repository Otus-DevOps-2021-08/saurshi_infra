terraform {
  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    region   = "ru-central"
    bucket   = "tf-app"
    key      = "tf-app/prod.tfstate"
    access_key = "uJ0-N_-B9BhQ22Png_sT"
    secret_key = "AoQfY__O3oAsE_kjbi0XfXGMRoNIa03PHIv8-P-1"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
  }
}
