#vim main.pkr.hcl

source "amazon-ebs" "app" {

  #access_key = "${var.access_key}"  #no need because role added
  #secret_key = "${var.secret_key}"
  #unique ami name using time stamp

  ami_name      = "${local.image-name}"
  region        = "${var.region}"
  instance_type = "t2.micro"
  ssh_username  = "ec2-user"


  tags = {
    Name    = "${local.image-name}"
    project = "${var.project}"
    env     = "${var.env}"
  }

  source_ami_filter {
    filters = {
      virtualization-type = "hvm"
      name                = "amzn2-ami-kernel*-gp2"
      root-device-type    = "ebs"
    }
    owners      = ["amazon"]
    most_recent = true
  }

}



build {
  sources = ["source.amazon-ebs.app"]

  provisioner "shell" {
    script          = "userdata.sh"
    execute_command = "sudo  {{.Path}}"
  }

}

