variable "name" {
  type        = string
  default     = "Medstick_sg_lb"
  description = "Security group name of load balancer"
  validation {
    condition     = length(var.name) > 0
    error_message = "The name must not be an empty string."
  }
}

variable "description" {
  type        = string
  default     = "Module by terraform"
  description = "Description of the security group"
  validation {
    condition     = length(var.description) > 0
    error_message = "The description must not be an empty string."
  }
}

variable "healthy_threshold" {
  type        = number
  default     = 2
  description = "Number of consecutive successful health checks required before considering an unhealthy target healthy"
  validation {
    condition     = var.healthy_threshold >= 2
    error_message = "The healthy threshold must greater then 2."
  }
}

variable "unhealthy_threshold" {
  type        = number
  default     = 2
  description = "Number of consecutive failed health checks required before considering a target unhealthy"
  validation {
    condition     = var.unhealthy_threshold >= 2
    error_message = "The unhealthy threshold must be greater then 2."
  }
}

variable "timeout" {
  type        = number
  default     = 3
  description = "Amount of time, in seconds, during which no response from a target means a failed health check"
  validation {
    condition     = var.timeout == 3
    error_message = "Timeout must be equal to 3."
  }
}

variable "interval" {
  type        = number
  default     = 30
  description = "Approximate amount of time, in seconds, between health checks of an individual target"
  validation {
    condition     = var.interval == 30
    error_message = "The interval value must be 30 sec."
  }
}

variable "lb_port" {
  type        = number
  default     = 80
  description = "Load balancer port"
  validation {
    condition     = var.lb_port == 80
    error_message = "The lb port must be 80."
  }
}

variable "instance_port" {
  type        = number
  default     = 80
  description = "Instance port"
  validation {
    condition     = var.instance_port == 80
    error_message = "Instance port must be 80."
  }
}

variable "lb_protocol" {
  type        = string
  default     = "http"
  description = "Load balancer protocol"
  validation {
    condition     = var.lb_protocol == "http"
    error_message = "Lb protocol must be equal to http."
  }
}

variable "instance_protocol" {
  type        = string
  default     = "http"
  description = "Instance protocol"
  validation {
    condition     = var.instance_protocol == "http"
    error_message = "Instance protocol should be equal to http."
  }
}

variable "lb_name" {
  type        = string
  default     = "medstick-prodelb"
  description = "Name of load balancer"
  validation {
    condition     = length(var.lb_name) > 0
    error_message = "The lb name  must not be an empty string."
  }
}

variable "vpc_id" {
  type        = string
  description = "Vpc id"
  validation {
    condition     = length(var.vpc_id) > 0
    error_message = "The vpc id  must not be an empty string."
  }
}

variable "subnets" {
  type        = any
  default     = []
  description = "Subnets for the load balancer"
  validation {
    condition     = length(var.subnets) > 0
    error_message = "The subnet should not be empty."
  }
}


