variable "chef_workstation_dl_url" {
  type    = "string"
  default = "https://packages.chef.io/files/stable/chef-workstation/0.2.53/windows/2016/chef-workstation-0.2.53-1-x64.msi"
}

variable "workstation_ips" {
  default = []
}

variable "workstation_count" {
  default = 1
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
