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