# Connect to a container running in the "app" namespace
kubectl exec --stdin --tty app-deployment-64d86c576d-9jtpp -n app -- /bin/bash