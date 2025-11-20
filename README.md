# autospotr-iac

This project uses Terraform (IaC) to deploy the Autospotr plaform to Firebase

### Requirements
- Google Cloud Service Account
- [Install gcloud CLI](https://cloud.google.com/sdk/docs/install)
- [Install Cloud Build for GitHub App](https://github.com/apps/google-cloud-build)
- [Install Terraform](https://developer.hashicorp.com/terraform/install)

---

### Setup Project

Copy `.env-sample` file to `.env` and define the environment variables s

Login to Google Cloud Services
```
gcloud init
gcloud auth application-default login
```
From this project directory, initialize Terraform
```
terraform init
```

---


### Running  Terraform

#### Review Provisioning
```
terraform plan
```

#### Execute Provisioning using .env file
```
source .env && terraform apply
```

#### Confirm Provisioning
```
terraform show
```

#### Destory Provisioning
```
source .env && terraform destroy
```# autospotr-iac
