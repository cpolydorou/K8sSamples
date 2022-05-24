###################################################################################################################
# A script to wait until nginx has been deployed
###################################################################################################################

echo -n "Wait for pod app.kubernetes.io/component=controller to be created."
while : ; do
  [ ! -z "`kubectl -n nginx get pod --selector=app.kubernetes.io/component=controller 2> /dev/null`" ] && echo && break
  sleep 2
  echo -n "."
done
### Wait pod is ready
timeout="600s"
echo -n "Wait for pod app.kubernetes.io/component=controller to be ready (timeout=$timeout)..."
kubectl wait  --namespace nginx \
              --for=condition=ready pod \
              --selector=app.kubernetes.io/component=controller \
              --timeout=$timeout
echo