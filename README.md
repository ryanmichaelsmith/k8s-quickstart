# k8s-quickstart

For each node:
- Edit /etc/hosts and add all nodes (or update dns)
- Run quickstart.sh
- For control-plane node:
  ```
  kubeadm init --control-plane-endpoint k8s-control-plane --pod-network-cidr=192.168.0.0/16
  export KUBECONFIG=/etc/kubernetes/admin.conf
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/tigera-operator.yaml
  kubectl create -f https://raw.githubusercontent.com/projectcalico/calico/v3.26.1/manifests/custom-resources.yaml
  ```
- For worker node, run this on the control-plane node and run the resultant command on the new worker node:
  ```
  kubeadm token create --print-join-command
  ```
