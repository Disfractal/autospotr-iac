variable env {}
variable firestore_name_postfix {}
variable project_id {}
variable region {}

terraform {

  required_providers {

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
      configuration_aliases = [ google-beta.default ]
    }

  }

}

resource "google_firestore_database" "default_firestore_database" {
  project                     = var.project_id
  name                        = "${var.env}${var.firestore_name_postfix}"
  location_id                 = var.region
  type                        = "FIRESTORE_NATIVE"
  delete_protection_state     = "DELETE_PROTECTION_DISABLED"
  deletion_policy             = "DELETE"
}