getent group kube-apiserver >/dev/null || groupadd -r kube-apiserver
getent passwd kube-apiserver >/dev/null || useradd -r -g kube-apiserver -d /var/kube-apiserver -s /sbin/nologin \
        -c "Kubernetes apiserver user" kube-apiserver

getent group kube-controller-manager >/dev/null || groupadd -r kube-controller-manager
getent passwd kube-controller-manager >/dev/null || useradd -r -g kube-controller-manager -d /var/kube-controller-manager -s /sbin/nologin \
        -c "Kubernetes controller-manager user" kube-controller-manager

getent group kube-scheduler >/dev/null || groupadd -r kube-scheduler
getent passwd kube-scheduler >/dev/null || useradd -r -g kube-scheduler -d /var/kube-scheduler -s /sbin/nologin \
        -c "Kubernetes scheduler user" kube-scheduler

getent group kube-cert >/dev/null || groupadd -r kube-cert

mkdir -p -m 755 /var/kube-apiserver
chown -R kube-apiserver /var/kube-apiserver
chgrp -R kube-apiserver /var/kube-apiserver

mkdir -p -m 755 /var/kube-controller-manager
chown -R kube-controller-manager /var/kube-controller-manager
chgrp -R kube-controller-manager /var/kube-controller-manager

mkdir -p -m 755 /var/kube-scheduler
chown -R kube-scheduler /var/kube-scheduler
chgrp -R kube-scheduler /var/kube-scheduler

mkdir -p -m 755 /var/run/kubernetes
chown -R kube-apiserver /var/run/kubernetes
chgrp -R kube-apiserver /var/run/kubernetes
