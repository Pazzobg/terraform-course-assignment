output "data_bucket_name" {
  value = module.tf_course_data_bucket.s3_bucket_name
}

output "data_bucket_arn" {
  value = module.tf_course_data_bucket.s3_bucket_arn
}

output "glue_database_all" {
  value = "Database: ${module.tf_course_glue_catalog_database.glue_data_catalog_database_name} with ARN: ${module.tf_course_glue_catalog_database.glue_data_catalog_database_arn}"
}
