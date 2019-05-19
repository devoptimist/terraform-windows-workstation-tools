# Important
This module connects via winrm and installs some chef related tools.

## Usage

```hcl
module "workstation_names" {
  source                     = "devoptimist/workstation-tools/windows"
  version                    = "0.0.3"
  workstation_use_chocolatey = true
  workstation_ips            = ["192.168.0.1", "192.168.0.2", "192.168.0.3"]
  winrm_password             = "MyP@ssW0rd!"
  winrm_user                 = "myuser"
}
```
The above example would install some development tools on to the 3 vms
that are accessible via the workstation_ips list.
the following is installed
* git
* vscode
* chef habitat
* google chrome
* chef-workstation

## Inputs

| Name | Description | Type | Default | Required |
|chef_workstation_dl_url| The url to the chef workstation msi | string | https://packages.chef.io/files/stable/chef-workstation/0.2.53/windows/2016/chef-workstation-0.2.53-1-x64.msi | no |
|workstation_ips| List of ip addresses to connect to |list|[]| yes |
|use_chocolatey| set to false to install via direct download rather than chocolatey| boolean | true | no|  
|winrm_password| The password for the winrm user we are using to connect | string | "" | yes |
|winrm_user| The user name for the winrm user we are using to connect | string | "" | yes |

