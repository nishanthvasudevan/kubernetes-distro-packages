getent group kubelet >/dev/null || groupadd -r kubelet
getent passwd kubelet >/dev/null || useradd -r -g kubelet -d /var/kubelet -s /sbin/nologin \
        -c "Kubernetes kubelet user" kubelet

getent group kube-proxy >/dev/null || groupadd -r kube-proxy
getent passwd kube-proxy >/dev/null || useradd -r -g kube-proxy -d /var/kube-proxy -s /sbin/nologin \
        -c "Kubernetes proxy user" kube-proxy

mkdir -p -m 755 /var/kube-proxy
chown -R kube-proxy /var/kube-proxy
chgrp -R kube-proxy /var/kube-proxy

mkdir -p -m 755 /var/lib/kubelet
