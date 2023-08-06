resource "google_storage_bucket" "data-lake-bucket" {
  name                        = var.data_source_bucket_name
  location                    = var.region

  versioning {
    enabled = true
  }

  autoclass {
    enabled = true
  }
}
