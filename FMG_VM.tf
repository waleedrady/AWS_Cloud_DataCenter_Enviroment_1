// FGTVM instance

resource "aws_network_interface" "FMG_eth0" {
  description = "${var.username}_Terraform_FMG_WAN"
  subnet_id   = aws_subnet.Virginia_Public_Subnet_1.id
  private_ips = var.FMG_WAN_IP

  tags = {
    Name = "${var.username}_TF_FMG_WAN"
  }
}


resource "aws_network_interface_sg_attachment" "FMG_WAN_Interface_to_Public_SG_Attachment" {
  depends_on           = [aws_network_interface.FMG_eth0]
  security_group_id    = aws_security_group.FMG_SG.id
  network_interface_id = aws_network_interface.FMG_eth0.id
}

resource "aws_instance" "WRady_Terraform_FMG" {
  ami               = lookup(var.FMG_VM_AMI, var.US_East_1)
  instance_type     = var.FMG_VM_Size
  availability_zone = data.aws_availability_zones.AZs_US_East_1.names[0]
  key_name          = var.keyname
  #user_data         = data.template_file.FortiGate.rendered

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "80"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.FMG_eth0.id
    device_index         = 0
  }

  tags = {
    Name = "${var.username}_TF_FMG"
  }
}