
# Terraform provider file for Google Cloud Firebase.
terraform {
  
  required_providers {
    
    github = {
      source  = "integrations/github"
      version = "~> 6.0"
    }

    google-beta = {
      source  = "hashicorp/google-beta"
      version = "~> 6.0"
    }

  }

}

# Configures the provider to use the resource block's specified project for quota checks.
provider "google-beta" {
  alias  = "default"
  user_project_override = true
}

# Configures the provider to not use the resource block's specified project for quota checks.
# This provider should only be used during project creation and initializing services.
provider "google-beta" {
  alias = "no_user_project_override"
  user_project_override = false
}

provider "github" {
  token = var.gh_token
  # Optionally, specify an organization if managing resources within one
  # organization = "your-github-organization"
}