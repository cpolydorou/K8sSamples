###################################################################################################################
# The deployment script for nginx
###################################################################################################################

# Select the namespace for nginx
NAMESPACE=nginx

# Add the helm repo
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update

# Create the ingress controller
helm install nginx-ingress ingress-nginx/ingress-nginx \
    --namespace $NAMESPACE \
    --set controller.replicaCount=2 \
    --set controller.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.nodeSelector.nodeType="infrastructure-node" \
    --set controller.admissionWebhooks.patch.nodeSelector."kubernetes\.io/os"=linux \
    --set controller.admissionWebhooks.patch.nodeSelector.nodeType="infrastructure-node" \
    --set controller.admissionWebhooks.patch.image.digest="" \
    --set defaultBackend.nodeSelector."kubernetes\.io/os"=linux \
    --set defaultBackend.nodeSelector.nodeType="infrastructure-node" \
    --set controller.extraArgs.enable-ssl-passthrough=""
