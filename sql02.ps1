Login-AzureRmAccount

$Credential = Get-Credential
Add-AzureRmAccount -Credential $Credential -TenantId  02817304-d4cd-48a3-b191-cda76ad68610

Select-AzureRmSubscription -SubscriptionId ‘75c9fb2b-31e2-42f1-b52d-be1089348edb’

$sas = Grant-AzureRmDiskAccess -ResourceGroupName "az-rsg-sql01" -DiskName "az-disk-sql02" -DurationInSecond 800000 -Access Read 

#Destination subscription 
Add-AzureRmAccount -Credential $Credential -TenantId  0d80b528-dc86-41c7-b085-808480774e32

Select-AzureRmSubscription -SubscriptionId ‘0a23c682-ebcc-43c1-b798-862185700d48’

$destContext = New-AzureStorageContext –StorageAccountName "vmstorejbw" -StorageAccountKey "QtHqoiah8ziHL1Ynlb6eKdVpMpIt/SaRV3unKmEIVtZptQEbeBBLBAwu8WyFVm8FvhXGtYdeMRelkeHTJDJoNA=="
$blobcopy=Start-AzureStorageBlobCopy -AbsoluteUri $sas.AccessSAS -DestContainer "vhds" -DestContext $destContext -DestBlob "sql02datadisk"
while(($blobCopy | Get-AzureStorageBlobCopyState).Status -eq "Pending")
{
    Start-Sleep -s 30
    $blobCopy | Get-AzureStorageBlobCopyState
} 