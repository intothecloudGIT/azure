$pipname = [public ip name]
$rgname = [resource group name]
$location = [region name]
$nicname = [name of nic]

# New-AzurePublicRmIAddress creates the new IP - Run this first. 
 new-azurermpublicIPAddress -Name $pipname -ResourceGroupName $rgname -AllocationMethod Static -Location $location
 
# Set the variables but getting the properties you need 
$nic = Get-AzurermNetworkInterface -ResourceGroupName $rgname -Name $nicname
$pip = Get-AzurermPublicIPAddress -ResourceGroupName $rgname -Name $pipname
$nic.IPConfigurations[0].PublicIPAddress=$pip
 
# Finally set the IP address against the NIC
Set-AzureRmNetworkInterface -NetworkInterface $nic