//AWS Configuration
variable access_key {}
variable secret_key {}


//  Resources name Prefix & FGT admin & VPN Username

variable "username" {
  default = "<Your Name>"
}

//  FGT Admin Password & VPN user Passsword

variable "FGT_Password" {
  default = "<Your Password>"
}


variable "US_East_1" {
  default = "us-east-1"
}


//  FMG FQDN configred in the FGT

variable "FMG_FQDN" {
  default = "FMG.<Your Domain>"
}



variable "USEast1_VPC" {
  default = "10.150.0.0/16"
}

variable "virginia_public_subnet_1" {
  default = "10.150.1.0/24"
}

variable "virginia_public_subnet_2" {
  default = "10.150.2.0/24"
}

variable "virginia_private_subnet_1" {
  default = "10.150.5.0/24"
}



// FGT eth0 (WAN) Interface IP 
variable "FGT_WAN_IP" {
  default = ["10.150.1.10"]
}

// FGT eth1 (LAN) Interface IP 
variable "FGT_LAN_IP" {
  default = ["10.150.5.5"]
}

// FMG eth0 (WAN) Interface IP 
variable "FMG_WAN_IP" {
  default = ["10.150.1.20"]
}

// Ubuntu eth0 (LAN) Interface IP 
variable "Ubuntu_LAN_IP" {
  default = ["10.150.5.10"]
}


// AMIs are for FGTVM-AWS(PAYG) - 7.0
variable "FGT_VM_AMI" {
  type = map
  default = {
    us-east-1 = "ami-01a54d044634cf0f6"
  }
}

// AMIs are for FMG AWS (2 Devices) - 6.4.5
variable "FMG_VM_AMI" {
  type = map
  default = {
    us-east-1 = "ami-03389c3d9b8f13b32"
  }
}

// Ubuntu 20.04 LTS
variable "Ubuntu_WebServer_AMI" {
  type = map
  default = {
    us-east-1 = "ami-042e8287309f5df03"
  }
}


variable "FMG_VM_Size" {
  default = "t2.medium"
}

variable "FGT_VM_Size" {
  default = "t2.small"
}

variable "Ubuntu_VM_Size" {
  default = "t3.micro"
}

//  Existing SSH Key on the AWS
variable "keyname" {
  default = "<Your AWS Keypair"
}


variable "adminsport" {
  default = "443"
}

variable "bootstrap-fgtvm" {
  type    = string
  default = "fgtvm.conf"
}
