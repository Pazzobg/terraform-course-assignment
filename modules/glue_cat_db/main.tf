# Create Glue Catalog database
resource "aws_glue_catalog_database" "catalog_db" {
  name = "${var.project_name}-${var.catalog_database_name}"
}
