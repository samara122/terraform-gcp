output "billing_name" {
  value = data.google_billing_account.my_acct.display_name
}

output "billing_id" {
  value = data.google_billing_account.my_acct.id
}

output "random_result" {
  value = random_string.my_str.result
}