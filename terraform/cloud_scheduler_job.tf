resource "google_cloud_scheduler_job" "job" {
  provider         = google-beta
  name             = "schedule-job"
  description      = "test http job"
  schedule         = "*/8 * * * *"
  attempt_deadline = "320s"
  region           = "us-central1"
  project          = data.google_project.project.project_id

  retry_config {
    retry_count = 3
  }

  http_target {
    http_method = "POST"
    uri         = "https://${google_cloud_run_v2_job.default.location}-run.googleapis.com/apis/run.googleapis.com/v1/namespaces/${data.google_project.project.number}/jobs/${google_cloud_run_v2_job.default.name}:run"

    oauth_token {
      service_account_email = google_service_account.cloud_run_invoker_sa.email
    }
  }

  depends_on = [resource.google_project_service.cloudscheduler_api, resource.google_cloud_run_v2_job.default, resource.google_cloud_run_v2_job_iam_binding.binding]
}
