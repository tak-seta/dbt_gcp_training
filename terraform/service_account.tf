# resource "google_service_account" "dbt-training-sa" {
#   project      = var.gcp_project_id
#   account_id   = "dbt-training-sa"
#   display_name = "test-sa"
# }

# resource "google_project_iam_member" "sample" {
#   project = var.gcp_project_id
#   role    = "roles/run.admin"
#   member  = "serviceAccount:${google_service_account.dbt-training-sa.email}"
# }
