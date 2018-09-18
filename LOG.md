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

2. Boot it up! (cloud-init will configure a kubernetes cluster 🙀)

### Setting up a node

1. Configure the OS

```bash
$ flash --hostname <change-me>--userdata cloud-init/nodes.yaml https://github.com/hypriot/image-builder-rpi/releases/download/v1.9.0/hypriotos-rpi-v1.9.0.img.zip 
```

2. Boot it up (shell into it and wait for kubeadm to be installed)

```bash
# on the master
$ kubeadm token create

# on the nodes
$ ping master-01 # or master-0.local
$ kubeadm join --token <token> master-01 # or the IP if that doesn't resolve
```

#### Optional

Configure WiFI: see the `cloud-init/nodes.yaml`