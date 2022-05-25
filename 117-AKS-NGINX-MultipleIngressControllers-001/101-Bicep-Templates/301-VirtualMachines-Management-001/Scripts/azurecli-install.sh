# Prerequisites
apt-get update
apt-get install ca-certificates curl apt-transport-https lsb-release gnupg -y

# Custom repo
curl -sL https://packages.microsoft.com/keys/microsoft.asc |
gpg --dearmor |
sudo tee /etc/apt/trusted.gpg.d/microsoft.gpg > /dev/null

echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $(lsb_release -cs) main" |
sudo tee /etc/apt/sources.list.d/azure-cli.list

# Azure CLI
sudo apt-get update
sudo apt-get install azure-cli -y
az --version