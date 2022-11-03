# Copyright 2017, 2021 Oracle Corporation and/or affiliates.
# Licensed under the Universal Permissive License v 1.0 as shown at https://oss.oracle.com/licenses/upl

# for reuse 

output "cluster_id" {
  description = "ID of the Kubernetes cluster"
  value       = module.oke.cluster_id
}

output "nodepool_ids" {
  description = "Map of Nodepool names and IDs"
  value       = module.oke.nodepool_ids
}

# Suppress reported output change on clean destroy
output "kubeconfig" {
  description = "convenient command to set KUBECONFIG environment variable before running kubectl locally"
  value       = length(module.oke.cluster_id) == 0 ? null : "export KUBECONFIG=generated/kubeconfig"
}
