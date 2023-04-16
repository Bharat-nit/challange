###################################################################################
#                 GET INSTANCE METADATA
#  Ex. ./Script.ps1 -VMName "VM1" -KeyName "name"
#  Ex. ./Script.ps1 -VMName "VM1" -KeyName "location"
###################################################################################
param (
    [Parameter( Mandatory=$true)]
    [string]$VMName,
    [string]$KeyName
)

#Get the VM Resource
$VM = Get-AzResource -Name $VMName

#Get Instance Metadata using IMDS API. This is remote Execution on the VM. 
$out = Invoke-AzVMRunCommand -ResourceGroupName $VM.ResourceGroupName -Name $VM.Name -CommandId 'RunPowerShellScript' -Scripts 'Invoke-RestMethod -Headers @{"Metadata"="true"} -Method GET -Uri "http://169.254.169.254/metadata/instance?api-version=2021-02-01" | ConvertTo-Json'
$metadata = $out.Value[0].Message
$data = $metadata | ConvertFrom-Json 
Write-Host "Instance Metadata JSON of VM - $VMName" -ForegroundColor DarkGreen
$metadata

# Get the Key Value
if ($KeyName) {
    Write-Host "Get the value of the Key - $KeyName" -ForegroundColor DarkGreen
    $data.compute.$KeyName
}
