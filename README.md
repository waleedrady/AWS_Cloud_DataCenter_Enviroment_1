# Cloud_DataCenter_Enviroment_1
- Cloud Data Center that builds FGT, FMG and an Apache Server in the US-East-1 Region (Virginia). FGT and FMG will be part of the public Subnet and the Apache server is protected by the FGT in the Private Subnet
- Script will also create 4 DNS records to easily reach the resources created instead of using IPs 


Variables that need to be modified:
- variables.tf
-     line 9 =  Your username
-     Line 15 = Your password
-     Line 25 = Enter FMG FQDN (will be configured on the FGT)
-     Line 110 = Copy and Paste your AWS Keypair name (EC2 --> Network & Security --> Key Pairs)


![image](https://user-images.githubusercontent.com/82145296/116725620-267d0d80-a9b0-11eb-8175-2e28086babd4.png)
