### build.ps1 - Build and push a Docker image to ACR, with an example of how to run the container
# Login to Azure with MSI
Connect-AzAccount -Identity # must be run as admin

# Retrieve secrets from keyvault and inject into docker build
Install-Module Az.KeyVault
Import-Module Az.KeyVault
$keyVaultName = "kv-bunnyai"
$uriSecretName = "ROBOFLOW-DATASET-URI"
$dataset_uri = Get-AzKeyVaultSecret -VaultName $keyVaultName -Name $uriSecretName -AsPlainText


$image_name = "train_bunnyai"
$tag = "latest"
$acr_login_server = "bunnyacr.azurecr.io"


az acr login -n $acr_login_server
docker build --build-arg DATASET_URI=$dataset_uri . -t $image_name

# Tag and push image to ACR
docker tag "$image_name`:$tag" "$acr_login_server/$image_name`:$tag"
docker push "$acr_login_server/$image_name`:$tag"

# Examples for running locally or from ACR
docker run -e EPOCHS=1 "$image_name`:$tag"
docker run -e EPOCHS=1 "$acr_login_server/$image_name`:$tag"
