resource "google_service_account" "dbt-training-sa" {
  project      = var.gcp_project_id
  account_id   = "dbt-training-sa"
  provider     = google-beta
  display_name = "test-sa"
}

resource "google_project_iam_member" "dbt-training-sa" {
  project      = var.gcp_project_id
  count = "${length(var.dbt_training_roles)}"
  role   = "${element(var.dbt_training_roles, count.index)}"
  member = "serviceAccount:${google_service_account.dbt-training-sa.email}"
}
