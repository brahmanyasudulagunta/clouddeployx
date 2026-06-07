module "frontend_bucket" {

  source = "./modules/s3"

  bucket_name = var.bucket_name
}

module "iam" {
  source = "./modules/iam"

  dynamodb_table_arns = [
    module.dynamodb.table_arn,
    module.contact_table.table_arn
  ]
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

module "contact_table" {

  source = "./modules/dynamodb"

  table_name = "clouddeployx-contacts"
}

module "contact_lambda" {

  source = "./modules/lambda"

  lambda_name = "clouddeployx-contact"

  role_arn = module.iam.role_arn

  zip_file = "../backend/lambda/contact-form/contact.zip"
}

module "api_gateway" {

  source = "./modules/api_gateway"

  visitor_lambda_arn = module.visitor_lambda.lambda_arn

  contact_lambda_arn = module.contact_lambda.lambda_arn
}
