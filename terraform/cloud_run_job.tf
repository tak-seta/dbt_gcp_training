resource "google_cloud_run_v2_job" "default" {
  provider     = google-beta
  name     = "dbt-transform"
  location = var.region
  launch_stage = "BETA"

  template {
    template {
      containers {
        image = "asia-northeast1-docker.pkg.dev/${var.gcp_project_id}/dbt-docker-repo/${var.container_image}"
      }
    }
  }
}
