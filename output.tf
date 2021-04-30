
output "FMG_Username" {
  value = var.username
}

output "FMG_Public_IP" {
  value = aws_eip.FMG_WAN_IP.public_ip
}

output "FortiManager_Password" {
  value = aws_instance.WRady_Terraform_FMG.id
}


output "FGT_EIP" {
  value = aws_eip.FGT_EIP.public_ip
}


output "FortiGate_Password" {
  value = aws_instance.WRady_Terraform_FGT.id
}


output "Ubuntu_WebServer_Private_IP" {
  value = aws_network_interface.Ubuntu_WebServer_eth0.private_ip
}

output "Ubntu_WebServer_SSH" {
  value = "ssh <Your Username>@linux.<Your Username >.fortinetpslab.com -p 2222"
}

