variable "chef_workstation_version" {
  type    = "string"
  default = "0.2.48"
}

variable "workstation_count" {
  default = 1
}

variable "workstation_ips" {
  default = []
}

variable "workstation_use_chocolatey" {
  default = true
}

variable "winrm_password" {
  type    = "string"
}

variable "winrm_user" {
  type    = "string"
}

variable "hab_version" {
  type    = "string"
  default = "0.81.0"
}
