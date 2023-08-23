# Definign Key Name for connection
variable "key_name" {
 default = "tests"
}
# Defining CIDR Block for VPC
variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
# Defining CIDR Block for Subnet
variable "subnet_cidr" {
  default = "10.0.1.0/24"
}
# Defining CIDR Block for 2d Subnet
variable "subnet1_cidr" {
  default = "10.0.2.0/24"
}
variable "ami_id" {
  type = string
  default  = "ami-0f5ee92e2d63afc18"
  description = "The id of the machine image (AMI) to use for the server."
}
variable "region" {
  type        = string
  default = "ap-south-1"
  description = "Region where the instance would be hosted."
}
variable "itype" {
  type        = string
  default = "t2.micro"
  description = "Instance size"
}

variable "subnet" {
  type        = string
  default = "subnetterraform-81896c8e"
  description = "subnet id"
}

variable "publicip" {
  type        = string
  default = "true"
  description = "public ip"
}

variable "keyname" {
  type        = string
  default = "myseckeyterrafr"
  description = "Keyname"
}

variable "secgroupname" {
  type        = string
  default = "IAC-Sec-Groupterra"
  description = "security group names"
}

variable "vpcid" {
  type        = string
  default = "vpc-5234832d"
  description = "VPC ID"
}

variable "volsize" {
  type        = number
  default = 8
  description = "Volume size of the instance"
}

variable "voltype" {
  type        = string
  default = "gp2"
  description = "Volume type of the instance"
}
variable "docker_image_tag" {
  type        = string
  default     = "prod"
  description = "This is the tag which will be used for the image that you created"
  
}

variable "immutable_ecr_repositories" {
  type    = bool
  default = true
}
variable "dbstoragesize" {
  type        = number
  default = 10
  description = "storage size of the db instance"
}

variable "rdspassword" {
  type        = string
  default = "Medstick123"
  description = "database password"
}


variable "ecrname" {
  type        = list(string)
  description = "The list of ecr names to create"
  default = [ "medstick-cloud-gateway-terraform", "medstick-config-server-terraform" ]
}

