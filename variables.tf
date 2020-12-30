#
variable "project" {
  default     = "desk-299907"
}

variable "credentials_file" { 
  default     = "./.ssh/desk-63dc14e14826.json"
}

variable "my_region" { 
  default     = "us-central1"
}
variable "my_zone" { 
  default     = "us-central1-c"
}
variable "my_network" { 
  default     = "camel-network"
}
variable "ip_cidr_range_private" {
    default = "10.12.0.0/24"
}

variable "disk_image" {
  description = "Centos-7"
  default     = "centos-7-v20201216"
}

variable "allow_ports_desk" {
  default =  ["22","5000-6000", "8080-9100", "3389"]
}


variable "public_key_path" {
  description = "Path to the ssh public key of user TERR"
  default     = "./.ssh/terr_pub"
}

#  will be useful if we automate something else
variable "private_key_path" {
  description = "Path to the ssh private key of user TERR"
  default     = "./.ssh/terr_priv"
}

variable "public_key_path_of_root" {
  description = "Path to the ssh public key of user root"
  default     = "./.ssh/id_rsaroot.pub"
}
