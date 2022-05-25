# Download kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

# Update the permissions
chmod +x ./kubectl

# Move the file
mv ./kubectl /usr/local/bin/kubectl