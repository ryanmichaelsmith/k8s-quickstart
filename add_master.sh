#!/bin/sh

set -eu

if ! command -v yq &> /dev/null
then
	apt-get update && apt-get install -y yq
fi

join_command=$(kubeadm token create --print-join-command) 
kubectl get cm kubeadm-config -n kube-system -o yaml | yq -r .data.ClusterConfiguration > kubeadm-config.yaml
cert_key=$(kubeadm init phase upload-certs --upload-certs --config kubeadm-config.yaml | tail -n 1)

echo "Please enter this command on next master:"
echo "$join_command --control-plane --certificate-key $cert_key"
