if [ "$BASH" ]; then
  if [ -f ~/.bashrc ]; then
    . ~/.bashrc
  fi
fi

# local cluster config
kubectl config set-cluster minikube \
    --server=https://10.3.0.1 \
    --certificate-authority=.secret/ca.pem
kubectl config set-credentials default-admin \
    --certificate-authority=.secret/ca.pem \
    --client-key=.secret/admin-key.pem \
    --client-certificate=.secret/admin.pem
kubectl config set-context minikube \
    --cluster=minikube \
    --user=default-admin
kubectl config use-context minikube
