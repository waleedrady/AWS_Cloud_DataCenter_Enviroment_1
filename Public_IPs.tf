// FortiManager Public IP

resource "aws_eip" "FMG_WAN_IP" {
  depends_on        = [aws_instance.WRady_Terraform_FMG]
  vpc               = true
  network_interface = aws_network_interface.FMG_eth0.id

  tags = {
    Name       = "${var.username}_FMG_WAN"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}


resource "aws_eip" "FGT_EIP" {
  depends_on        = [aws_instance.WRady_Terraform_FGT]
  vpc               = true
  network_interface = aws_network_interface.FGT_eth0.id

  tags = {
    Name       = "${var.username}_FGT_WAN"
    Owner      = var.username
    Enviroment = "Terraform Testing"
  }
}