# k8s-quickstart

### For each node:
- Edit /etc/hosts and add all nodes (or update dns)
- Run quickstart.sh
- For control-plane node:
  ```
  export POD_NETWORK_CIDR="192.168.0.0/16"
  kubeadm init --control-plane-endpoint k8s-control-plane --pod-network-cidr=$POD_NETWORK_CIDR
  export KUBECONFIG=/etc/kubernetes/admin.conf
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
  ```
- For worker node, run this on the control-plane node and run the resultant command on the new worker node:
  ```
  kubeadm token create --print-join-command
  ```

### Future work
- Create Ansible Playbook smilar to:
  https://buildvirtual.net/deploy-a-kubernetes-cluster-using-ansible/
