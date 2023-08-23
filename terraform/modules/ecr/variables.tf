variable "encryption_type" {
  type        = string
  default     = "AES256"
  description = "Encryption type in ecr"
  validation {
    condition     = var.encryption_type == "AES256"
    error_message = "Encryption type of ecr should be AES256."
  }
}

variable "ecrname" {
  type        = list(string)
  default     = ["medstick-cloud-gateway-terraform", "medstick-config-server-terraform"]
  description = "List of ecr repositories to create"
  validation {
    condition     = length(var.ecrname) > 0
    error_message = "Ecr name must not be an empty string."
  }
}

variable "immutable_ecr_repositories" {
  type        = bool
  default     = true
  description = "Image tag mutability"
  validation {
    condition     = var.immutable_ecr_repositories == true
    error_message = "Immutable ecr repositories should be set to true."
  }
}

variable "create_duration" {
  type        = string
  default     = "300s"
  description = "Sleep time for ecr"
  validation {
    condition     = var.create_duration == "300s"
    error_message = "Sleep duration time should be set to 300s."
  }
}
