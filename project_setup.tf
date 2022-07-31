data "google_billing_account" "my_acct" {
    display_name = "My Billing Account"
}

resource "random_string" "my_str" {
  length           = 10
  special          = false
  number           = false
}