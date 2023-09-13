resource "google_cloud_scheduler_job" "job" {
  provider         = google-beta
  name             = "schedule-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  attempt_deadline = "320s"
  region           = var.region
  project          = var.gcp_project_id

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.default.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${var.gcp_project_id}/jobs/${google_cloud_run_v2_job.default.name}:run"

    # oauth_token {
    #   service_account_email = google_service_account.cloud_run_invoker_sa.email
    # }
  }

  depends_on = [resource.google_cloud_run_v2_job.default]
}
