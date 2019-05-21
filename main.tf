data "template_file" "install_ws" {
  template = "${file("${path.module}/templates/install_ws.ps1")}"

  vars {
    chef_workstation_version = "${var.chef_workstation_version}",
    use_chocolatey           = "${var.workstation_use_chocolatey}",
    user                     = "${var.winrm_user}",
    hab_version              = "${var.hab_version}",
    chef_workstation_version = "${var.chef_workstation_version}"
  }
}

resource "null_resource" "workstation_base_install" {
  count = "${var.workstation_count}"

  triggers {
    template = "${data.template_file.install_ws.rendered}"
  }

  connection {
    type     = "winrm"
    user     = "${var.winrm_user}"
    password = "${var.winrm_password}"
    host     = "${var.workstation_ips[count.index]}"
  }

  provisioner "file" {
    destination = "C:/install_ws.ps1"
    content     = "${data.template_file.install_ws.rendered}"
  }

  provisioner "remote-exec" {
    inline = [
      "powershell -ExecutionPolicy ByPass -File C:\\install_ws.ps1"
    ]
  }
}

