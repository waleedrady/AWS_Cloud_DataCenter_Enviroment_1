// FGTVM instance

resource "aws_network_interface" "FGT_eth0" {
  description = "${var.username}_Terraform_FGT_WAN"
  subnet_id   = aws_subnet.Virginia_Public_Subnet_1.id
  private_ips = var.FGT_WAN_IP

  tags = {
    Name = "${var.username}_TF_FGT_WAN"
  }
}


resource "aws_network_interface" "FGT_eth1" {
  description       = "${var.username}_TF_FGT_LAN"
  subnet_id         = aws_subnet.Virginia_Private_Subnet_1.id
  source_dest_check = false
  private_ips       = var.FGT_LAN_IP

  tags = {
    Name = "${var.username}_TF_FGT_LAN"
  }
}


resource "aws_network_interface_sg_attachment" "FGT_WAN_Interface_to_Public_SG_Attachment" {
  depends_on           = [aws_network_interface.FGT_eth0]
  security_group_id    = aws_security_group.Public_SG.id
  network_interface_id = aws_network_interface.FGT_eth0.id
}

resource "aws_network_interface_sg_attachment" "FGT_LAN_Interface_to_Private_SG_Attachment" {
  depends_on           = [aws_network_interface.FGT_eth1]
  security_group_id    = aws_security_group.Private_SG.id
  network_interface_id = aws_network_interface.FGT_eth1.id
}


resource "aws_instance" "WRady_Terraform_FGT" {
  ami               = lookup(var.FGT_VM_AMI, var.US_East_1)
  instance_type     = var.FGT_VM_Size
  availability_zone = data.aws_availability_zones.AZs_US_East_1.names[0]
  key_name          = var.keyname
  user_data         = data.template_file.FortiGate.rendered

  root_block_device {
    volume_type = "standard"
    volume_size = "2"
  }

  ebs_block_device {
    device_name = "/dev/sdb"
    volume_size = "30"
    volume_type = "standard"
  }

  network_interface {
    network_interface_id = aws_network_interface.FGT_eth0.id
    device_index         = 0
  }

  network_interface {
    network_interface_id = aws_network_interface.FGT_eth1.id
    device_index         = 1
  }

  tags = {
    Name = "${var.username}_TF_FGT"
  }
}


data "template_file" "FortiGate" {
  template = file(var.bootstrap-fgtvm)
  vars = {
    adminsport   = "${var.adminsport}"
    username     = "${var.username}"
    FGT_Password = "${var.FGT_Password}"
    FMG_FQDN     = "${var.FMG_FQDN}"
  }
}

