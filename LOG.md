## Installation

So, first off, we need to setup our master (for Kubernetes). Later on we will configure a `cloud-init` file
that will greatly simplify spinning up nodes.

**Note**: This is going to be geared to a private network, and is assumed you are using Ethernet only.

**IMPORTANT Note**: This is not meant to be 100% production ready, so there may be some issues, but it should scale pretty well.

### Setting up the Master

**Note** Make sure you look through the `cloud-init` files to add your, or someone else's SSH keys and etc.

1. Configure <LINK>HypriotOS (kinda like [Core/Rancher]OS but for ARM)

```bash
$ flash --userdata cloud-init/masters.yaml https://github.com/hypriot/image-builder-rpi/releases/download/v1.9.0/hypriotos-rpi-v1.9.0.img.zip 
```

2. SSH into the master node you just created, 

```bash
$ ssh pirate@master-01.local
# password is 'hypriot'
```

3. Install kubeadm

```bash
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb http://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt install kubeadm
```

4. Configure Kubernetes

```bash
sudo kubeadm init --pod-network-cidr 10.244.0.0/16
sudo cp /etc/kubernetes/admin.conf "$HOME/"
sudo chown $(id -u):$(id -g) "$HOME/admin.conf"
export KUBECONFIG="$HOME/admin.conf"
```

5. Install flannel

```bash
$ kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
```