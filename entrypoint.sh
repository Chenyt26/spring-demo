#!/bin/sh -l

curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(<kubectl.sha256) kubectl" | sha256sum --check

chmod +x kubectl
mv ./kubectl /usr/local/bin
kubectl version --client=true


curl -LO "https://cci-iam-authenticator.obs.cn-north-4.myhuaweicloud.com/latest/linux-amd64/cci-iam-authenticator"
chmod +x ./cci-iam-authenticator
mv ./cci-iam-authenticator /usr/local/bin
cci-iam-authenticator generate-kubeconfig --cci-endpoint=https://cci.cn-north-4.myhuaweicloud.com --ak=${{ secrets.ACCESSKEY }} --sk=${{ secrets.SECRETACCESSKEY }}
