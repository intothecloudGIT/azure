Import-Module AzureRM

Login-AzureRMAccount
Select-AzureRmSubscription -SubscriptionId '38fe47e2-af8c-4544-8782-392975abc60e'
$location="westeurope"
$vms=Get-AzureRmVMUsage -Location $location | select @{label="Name";expression={$_.name.LocalizedValue}},currentvalue,limit
$storages=Get-AzureRmStorageUsage | select-object name,currentvalue,limit
$networks=Get-AzureRmNetworkUsage -Location $location | select-object @{label="Name";expression={$_.resourcetype}},currentvalue,limit
$result=$vms+$storages+$networks
$result | Export-CSV ".\azure_usage_report.csv" 