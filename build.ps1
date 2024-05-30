### build.ps1 - Build and push a Docker image to ACR, with an example of how to run the container
# Login to Azure with MSI
Connect-AzAccount -Identity # must be run as admin

# Retrieve the secret from Azure Key Vault
Install-Module Az.KeyVault
Import-Module Az.KeyVault
$keyVaultName = "kv-bunnyai"
$secretName = "ROBOFLOW-API-KEY"
$key = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $secretName -AsPlainText

$workspaceName="bunnyai"
$projectName="animals-7fizt"
$datasetVersion="/app/animals-2/data.yaml"
$image_name = "train_bunnyai"
$tag = "latest"
$acr_login_server = "bunnyacr.azurecr.io"

az acr login -n $acr_login_server
docker build . -t $image_name
docker tag "$image_name`:$tag" "$acr_login_server/$image_name`:$tag"
docker push "$acr_login_server/$image_name`:$tag"

docker run -e ROBOFLOW_API_KEY=$key -e ROBOFLOW_WORKSPACE=$workspaceName -e ROBOFLOW_PROJECT=$projectName -e DATA=$datasetVersion -e EPOCHS=1 "$image_name`:$tag"
docker run -e ROBOFLOW_API_KEY=$key -e ROBOFLOW_WORKSPACE=$workspaceName -e ROBOFLOW_PROJECT=$projectName -e DATA=$datasetVersion -e EPOCHS=1 "$acr_login_server/$image_name`:$tag"
