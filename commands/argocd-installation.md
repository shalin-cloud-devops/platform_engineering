# Argo CD Installation — EKS

## 1. Connect kubectl to the EKS cluster

```bash
aws eks update-kubeconfig --region us-east-1 --name mutualfund-app-eks
```

Updates kubeconfig so kubectl uses the `mutualfund-app-eks` EKS cluster.

---

## 2. Check installed tools and cluster

```bash
kubectl version -short
```
aws eks describe-cluster \
    --name mutualfund-app-eks \
    --query "cluster.[version, platformVersion]" \
    --output text

Shows the installed kubectl and EKS version.

```bash
kubectl get nodes
```
Checks that the EKS nodes are reachable.

```bash
helm version
```

Shows the installed Helm version.

---

## 3. Add and check the Argo CD Helm chart

```bash
helm repo add argo https://argoproj.github.io/argo-helm
```

Adds the Argo CD Helm repository.

```bash
helm repo update
```

Updates the local list of charts from the repositories.

```bash
helm search repo argo/argo-cd
```

Checks that the Argo CD chart is available.

```bash
helm show chart argo/argo-cd
```

Shows information about the Argo CD chart, including its current/default version.

---

## 4. Install Argo CD

```bash
helm upgrade --install my-argocd argo/argo-cd \
  --namespace argocd \
  --version 10.7.1 \
  --create-namespace
```

Installs Argo CD using Helm.

- `my-argocd` = Helm release name
- `--namespace argocd` = install into the `argocd` namespace
- `--version 10.7.1` = use this chart version
- `--create-namespace` = create the namespace if it does not exist

---

## 5. Verify the installation

```bash
helm list -n argocd
```

Shows the Argo CD Helm release.

```bash
kubectl get pods -n argocd
```

Checks that Argo CD pods are running.

```bash
kubectl get all -n argocd
```

Shows the main Kubernetes resources in the Argo CD namespace.

```bash
kubectl get crd | grep argoproj.io
```

Shows the Custom Resource Definitions installed by Argo CD.

---

## 6. Get the initial Argo CD password

```bash
kubectl -n argocd get secret argocd-initial-admin-secret \
  -o jsonpath="{.data.password}" | base64 -d
echo
```

Gets and decodes the initial `admin` password.

---

## 7. Access the Argo CD UI

Run this on the bastion/SSM instance:

```bash
kubectl port-forward svc/my-argocd-server -n argocd 8080:443 &
```

Forwards port `8080` on the bastion to the Argo CD server.

Then run this from your local machine:

```bash
aws ssm start-session \
  --target i-018328baacad8d944 \
  --document-name AWS-StartPortForwardingSession \
  --parameters '{"portNumber":["8080"],"localPortNumber":["8080"]}'
```

Creates an SSM tunnel from your local machine to port `8080` on the bastion.

Deploy Root Application - App of Apps

kubectl apply -f https://raw.githubusercontent.com/shalin-cloud-devops/platform_engineering/main/bootstrap/root.yaml

kubectl logs -n karpenter -l app.kubernetes.io/name=karpenter -c controller --tail=500 | grep -iE "error|fail|ec2nodeclass"
