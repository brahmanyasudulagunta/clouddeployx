module "frontend_bucket" {

  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "iam" {
  source = "./modules/iam"
}

module "hello_lambda" {

  source = "./modules/lambda"

  lambda_name = "clouddeployx-hello"

  role_arn = module.iam.role_arn

  zip_file = "../backend/lambda/hello/lambda.zip"
}

module "dynamodb" {

  source = "./modules/dynamodb"

  table_name = "clouddeployx-visitors"
}

module "visitor_lambda" {

  source = "./modules/lambda"

  lambda_name = "clouddeployx-visitor"

  role_arn = module.iam.role_arn

  zip_file = "../backend/lambda/visitor-counter/visitor.zip"
}
