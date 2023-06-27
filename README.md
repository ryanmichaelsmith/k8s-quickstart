# k8s-quickstart

### For each node:
- Edit /etc/hosts and add all nodes (or update dns)
- Run quickstart.sh
- For control-plane node (assuming host name is k8s-master1):
  ```
  export POD_NETWORK_CIDR="192.168.0.0/16"
  kubeadm init --control-plane-endpoint k8s-master1 --pod-network-cidr=$POD_NETWORK_CIDR
  export KUBECONFIG=/etc/kubernetes/admin.conf
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
  curl -O https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
  sed -i -E "s|cidr: [0-9\.\/]+|cidr: $POD_NETWORK_CIDR|g" ./custom-resources.yaml
  kubectl create -f ./custom-resources.yaml
  ```
- For worker node, run this on the master node and run the resultant command on the new worker node:
  ```
  kubeadm token create --print-join-command
  ```
- For additional master nodes, run this on existing master and run the resultant command on new master node:
  ```
  bash add_master.sh
  ```

### Future work
- Create Ansible Playbook similar to:
  https://buildvirtual.net/deploy-a-kubernetes-cluster-using-ansible/
