output "table_name" {
  value = aws_dynamodb_table.visitor_table.name
}

output "table_arn" {
  value = aws_dynamodb_table.visitor_table.arn
}
