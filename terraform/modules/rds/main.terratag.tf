######## Create RDS ########
resource "aws_db_instance" "medstick_prodrds" {
  allocated_storage   = var.dbstoragesize
  storage_type        = var.storage_type
  identifier          = var.identifier
  engine              = var.engine
  engine_version      = var.engine_version
  instance_class      = var.instance_class
  username            = var.username
  password            = sensitive(var.rdspassword)
  port                = var.dbport
  publicly_accessible = false
  skip_final_snapshot = true

  tags = local.terratag_added_main
}

locals {
  terratag_added_main = { "Project" = "Medstick", "Project_Manager" = "Vrusha", "Purpose" = "Prod", "created_by" = "priyanka.pradhan@nineleaps.com", "environment_id" = "prod" }
}

