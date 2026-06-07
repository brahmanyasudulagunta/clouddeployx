output "bucket_name" {
  value = module.frontend_bucket.bucket_name
}

output "api_gateway_url" {
  value = module.api_gateway.invoke_url
}
