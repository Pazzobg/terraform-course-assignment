module "tf_course_data_bucket" {
  source = "./modules/s3_encrypted/"

  project_name                     = var.project_name
  bucket_name                      = "uniquely-named-bucket-74658645311358"
  kms_key_deletion_window_in_days  = 7
  create_120_days_bucket_lifecycle = true
  lifecycle_rule_status            = "Enabled"
}

module "tf_course_glue_catalog_database" {
  source = "./modules/glue_cat_db/"

  project_name          = var.project_name
  catalog_database_name = "prod-database"
}

module "tf_course_glue_crawler" {
  source = "./modules/glue_cat_crawler/"

  project_name              = var.project_name
  crawler_name              = "mapping-data-crawler"
  database_name             = module.tf_course_glue_catalog_database.glue_data_catalog_database_name
  crawler_target_bucket     = module.tf_course_data_bucket.s3_bucket_name
  target_bucket_kms_key_arn = module.tf_course_data_bucket.s3_bucket_encryption_key_arn
}
