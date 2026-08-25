output "cluster_name" {
  value = module.eks.cluster_name

}

output "bastion_IP" {
  value = module.bastion_host.public_ip

}
