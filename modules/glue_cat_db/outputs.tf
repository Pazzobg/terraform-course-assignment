output "glue_data_catalog_database_name" {
  value = aws_glue_catalog_database.catalog_db.name
}

output "glue_data_catalog_database_arn" {
  value = aws_glue_catalog_database.catalog_db.arn
}
