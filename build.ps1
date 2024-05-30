# build.ps1

$image_name = "train_bunnyai"
$tag = "latest"
$acr_login_server = "bunnyacr.azurecr.io"

docker build . -t $image_name
docker tag "$image_name`:$tag" "$acr_login_server/$image_name`:$tag"
docker push "$acr_login_server/$image_name`:$tag"

# Login to Azure with MSI
Connect-AzAccount -Identity # must be run as admin

# Retrieve the secret from Azure Key Vault
Install-Module Az.KeyVault
Import-Module Az.KeyVault
$keyVaultName = "kv-bunnyai"
$workspaceName="bunnyai"
$projectName="animals-7fizt"
$datasetVersion="animals-2"
$modelName="yolov8n.pt"
$secretName = "ROBOFLOW-API-KEY"
$key = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -AsPlainText

docker run -e ROBOFLOW_API_KEY=$key -e ROBOFLOW_WORKSPACE=$workspaceName -e ROBOFLOW_PROJECT=$projectName -e DATA=$datasetVersion -e MODEL=$modelName "$acr_login_server/$image_name`:$tag"
