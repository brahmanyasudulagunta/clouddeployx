resource "aws_s3_bucket" "frontend_bucket" {

  bucket = var.bucket_name

  tags = {
    Project = "CloudDeployX"
    Owner   = "Ashrith"
  }
}
