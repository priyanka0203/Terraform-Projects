variable "instance_class" {
  type        = string
  default     = "t2.micro"
  description = "Database instance type"
  validation {
    condition     = length(var.instance_class) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "dbport" {
  type        = number
  default     = 3306
  description = "Database port"
  validation {
    condition     = var.dbport == 3306
    error_message = "The variable must be 3306."
  }
}

variable "storage_type" {
  type        = string
  default     = "gp2"
  description = "Database storage type"
  validation {
    condition     = length(var.storage_type) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "identifier" {
  type        = string
  default     = "medstick-database"
  description = "Used as part of the dns hostname allocated to instance by rds"
  validation {
    condition     = length(var.identifier) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "engine" {
  type        = string
  default     = "mysql"
  description = "Database engine type"
  validation {
    condition     = length(var.engine) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "engine_version" {
  type        = string
  default     = "8.0.33"
  description = "Database engine version"
  validation {
    condition     = var.engine_version == "8.0.33"
    error_message = "The variable must not be an empty string."
  }
}

variable "username" {
  type        = string
  default     = "admin"
  description = "Rds username"
  validation {
    condition     = length(var.username) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "rdspassword" {
  type        = string
  default     = "Medstick123"
  description = "Rds Password"
  validation {
    condition     = length(var.rdspassword) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "dbstoragesize" {
  type        = number
  default     = 10
  description = "storage size of the db instance"
  validation {
    condition     = var.dbstoragesize >= 10
    error_message = "The db storage size should be greater then or equal to 10."
  }
}

