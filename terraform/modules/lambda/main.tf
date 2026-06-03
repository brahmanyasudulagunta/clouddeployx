resource "aws_lambda_function" "lambda" {

  function_name = var.lambda_name

  role = var.role_arn

  runtime = "python3.12"

  handler = "lambda_function.lambda_handler"

  filename = var.zip_file

  source_code_hash = filebase64sha256(var.zip_file)
}
