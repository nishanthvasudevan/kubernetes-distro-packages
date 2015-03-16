getent group etcd >/dev/null || groupadd -r etcd
getent passwd etcd >/dev/null || useradd -r -g etcd -d /var/lib/etcd \
  -s /sbin/nologin -c "etcd user" etcd

mkdir -p -m 755 /var/lib/etcd/default.etcd
chown -R etcd /var/lib/etcd
chgrp -R etcd /var/lib/etcd