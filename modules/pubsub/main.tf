
variable "env" {}
variable "project_id" {}

terraform {
  required_providers {
    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }
  }
}

resource "google_pubsub_topic" "transcoder_notifications" {
  project = var.project_id
  name = "${var.env}-autospotr-transcoder-notifications"
}

output "pubsub_id" {
    value  = google_pubsub_topic.transcoder_notifications.id
}

output "pubsub_name" {
    value  = google_pubsub_topic.transcoder_notifications.name
}