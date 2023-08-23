variable "min_size" {
  type        = number
  default     = 1
  description = "Minimum number of instances required"
  validation {
    condition     = var.min_size == 1
    error_message = "Minimum size in autoscaling group should be set to 1."
  }
}

variable "desired_capacity" {
  type        = number
  default     = 1
  description = "Desired number of instances"
  validation {
    condition     = var.desired_capacity == 1
    error_message = "Desired capacity in autoscaling group should be set to 1."
  }
}

variable "max_size" {
  type        = number
  default     = 2
  description = "Maximum number of instances"
  validation {
    condition     = var.max_size == 2
    error_message = "Maximum number of instances in autoscaling group should be set to 2."
  }
}

variable "health_check_type" {
  type        = string
  default     = "ELB"
  description = "Health check type of auto scaling group"
  validation {
    condition     = var.health_check_type == "ELB"
    error_message = "Health check type of auto scaling group should be set to ELB."
  }
}

variable "name_prefix" {
  type        = string
  default     = "Medstick-Prod"
  description = "Prefix of the name for the instances"
  validation {
    condition     = var.name_prefix == "Medstick-"
    error_message = "Prefix of the instance should be set to Medstick-."
  }
}

variable "image_id" {
  type        = string
  default     = "ami-0f5ee92e2d63afc18"
  description = "Image id of the instances"
  validation {
    condition     = var.image_id == "ami-0f5ee92e2d63afc18"
    error_message = "Image id should be set as mentioned above."
  }
}

variable "instance_type" {
  type        = string
  default     = "t2.micro"
  description = "Instance type"
  validation {
    condition     = length(var.instance_type) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "key_name" {
  type        = string
  default     = "Medstick_be_prod"
  description = "Key pair name"
  validation {
    condition     = length(var.key_name) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "secgrpid" {
  type        = any
  description = "Security group id of load balancer"
  validation {
    condition     = length(var.secgrpid) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "lbid" {
  type        = any
  description = "Load balancer id"
  validation {
    condition     = length(var.lbid) > 0
    error_message = "The variable must not be an empty string."
  }
}

variable "subnetid" {
  type        = any
  description = "Subnet id for the autoscaling group"
  validation {
    condition     = length(var.subnetid) > 0
    error_message = "The variable must not be an empty string."
  }
}


