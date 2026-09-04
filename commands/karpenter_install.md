kubectl config current-context

aws iam get-role --role-name karpenter-controller-role --query 'Role.Arn' --output text

helm install karpenter oci://public.ecr.aws/karpenter/karpenter \
  --version 1.9.1 \
  --namespace kube-system \
  --set "serviceAccount.annotations.eks\.amazonaws\.com/role-arn=arn:aws:iam::514005485562:role/karpenter-controller-role" \
  --set "settings.clusterName=mutualfund-app-eks" \
  --set "settings.interruptionQueue=karpenter-interruption-queue" \
  --wait

#kubectl logs deploy/karpenter, 
kubectl automatically looks up the active pods managed by karpenter(the deployment)

kubectl logs -n kube-system deploy/karpenter | grep -i -E "cred|assume|error|denied"


-----------

Check the node groups

aws eks list-nodegroups \
  --cluster-name mutualfund-app-eks

desribe it

aws eks describe-nodegroup \
  --cluster-name mutualfund-app-eks \
  --nodegroup-name mutual_fund_nodes-5c81ea3089189b14509b79a918 \
  --query 'nodegroup.nodeRole' \
  --output text