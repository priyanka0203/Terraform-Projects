variable "vpc_subnet_cidr" {
  description = "A nested cidr variable"
  type = list(object({
    cidr = string
  }))
  default = [
    {
      cidr = "10.0.0.0/16"
    },
    {
      cidr = "10.0.1.0/24"
    },
    {
      cidr = "10.0.2.0/24"
    }
  ]
  validation {
    condition     = length(var.vpc_subnet_cidr) > 0
    error_message = "The variable must not be an empty string."
  }
}





