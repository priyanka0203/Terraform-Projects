variable "created_by" {
  type    = string
  default = "priyanka.pradhan@nineleaps.com"
}

variable "Project" {
  type    = string
  default = "Medstick"
}

variable "Purpose" {
  type    = string
  default = "Prod"
}

variable "Project_Manager" {
  type    = string
  default = "Vrusha"
}

variable "region" {
  type        = string
  default     = "ap-south-1"
  description = "Region where the instance would be hosted."
}
