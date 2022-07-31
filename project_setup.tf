data "google_billing_account" "my_acct" {
    display_name = "My Billing Account"
}

resource "random_string" "my_str" {
  length           = 16
  special          = false
  number           = false
  lower = true
  upper = false
}

resource "google_project" "samara_gcp_project1" {
  name = "team3"
  project_id = random_string.my_str.id
  billing_account = data.google_billing_account.my_acct.id
}

resource "null_resource" "project_set" {
  triggers = {
    "always_run" = "${timestamp()}"
  }

  provisioner "local-exec" {
      command = "gcloud config set project ${google_project.samara_gcp_project1.project_id}"
  }
}

resource "null_resource" "project_unset" {
  provisioner "local-exec" {
      when = destroy
      command = "gcloud config unset project"
  }
}

resource "null_resource" "gcp-api-enable" {
  depends_on = [
    google_project.samara_gcp_project1,
    null_resource.project_set
  ]

  triggers = {
    "always_run" = "${timestamp()}"
  }

  provisioner "local-exec" {
      command = <<-EOT
        gcloud services enable compute.googleapis.com
        gcloud services enable dns.googleapis.com
        gcloud services enable storage-api.googleapis.com
        gcloud services enable container.googleapis.com
      EOT
  }
}