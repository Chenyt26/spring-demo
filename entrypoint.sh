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
cci-iam-authenticator generate-kubeconfig --cci-endpoint=https://cci.cn-north-4.myhuaweicloud.com --ak=${INPUT_ACCESS_KEY} --sk=${INPUT_SECRET_KEY}
# kubectl get ns
# kubectl get deployment -n cci-namespace-70395701
# kubectl get deploy -n cci-namespace-70395701
# kubectl get pods -n cci-namespace-70395701
# kubectl get rs -n cci-namespace-70395701
# kubectl describe deploy cci-deployment-20223141 -n cci-namespace-70395701
#kubectl rollout undo deployment cci-deployment-20223141 -n cci-namespace-70395701
#kubectl patch  deployment cci-deployment-20223141 -p '{"spec":{"strategy":{"type":"RollingUpdate"}}}' -n cci-namespace-70395701
#kubectl set image deploy cci-deployment-20223141 container-0=swr.cn-north-4.myhuaweicloud.com/hcloudcli/demo:v1.1 -n cci-namespace-70395701
kubectl rollout status cci-deployment-20223141 -n cci-namespace-70395701
