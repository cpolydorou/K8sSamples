# Connect to a container running in the "app" namespace
#kubectl exec --stdin --tty app-deployment-64d86c576d-9jtpp -n app -- /bin/bash
kubectl exec --stdin -it app-deployment-574d9dbfcb-87ndd -n app-a -c netshoot -- /bin/zsh



kubectl exec --stdin -it app-1-deployment-59d4b7648d-db926 -n app-1 -c netshoot -- /bin/zsh
kubectl exec --stdin -it app-2-deployment-6787fccf5-rr6lt -n app-2 -c netshoot -- /bin/zsh
kubectl exec --stdin -it app-3-deployment-66d8b5d4cd-rg4pz -n app-3 -c netshoot -- /bin/zsh

