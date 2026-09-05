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
  --nodegroup-name mutual_fund_nodes-f225badc1db5ba42df43e3f2ae \
  --query 'nodegroup.nodeRole' \
  --output text

-------------\

  106  kubectl get pods -A
  107  kubectl get nodes
  108  kubectl get nodes -L karpenter.sh/nodepool
  109  kubectl get nodes --show-labels
  110  kubectl get nodes -L eks.amazonaws.com/nodegroup -L karpenter.sh/nodepool
  111  clear
  112  kubectl get nodepool
  113  kubectl get nodes -L karpenter.sh/nodepool
  114  kubectl get node ip-10-0-2-212.ec2.internal   -o jsonpath='{.metadata.labels.karpenter\.sh/nodepool}{"\n"}'
  115  kubectl get nodes   -L karpenter.sh/nodepool   -L eks.amazonaws.com/nodegroup