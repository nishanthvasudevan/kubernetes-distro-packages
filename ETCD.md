

System.d and RedHat 7 / CentOS 7 Manual Install
=======
curl -L  https://github.com/coreos/etcd/releases/download/v2.0.4/etcd-v2.0.4-linux-amd64.tar.gz -o etcd-v2.0.4-linux-amd64.tar.gz
tar xzvf etcd-v2.0.4-linux-amd64.tar.gz

cd etcd-v2.0.4-linux-amd64
sudo cp etcd /usr/local/bin/
sudo cp etcdctl /usr/local/bin/
sudo cp etcd-migrate /usr/local/bin/
su
getent group etcd >/dev/null || groupadd -r etcd
getent passwd etcd >/dev/null || useradd -r -g etcd -d /var/lib/etcd \
  -s /sbin/nologin -c "etcd user" etcd
exit
sudo mkdir -p /var/lib/etcd/data/default
sudo mkdir -p /var/lib/etcd/data/member
sudo chown -R etcd /var/lib/etcd
sudo chgrp -R etcd /var/lib/etcd


*copy master/etc/etcd code to /etc/etcd*
sudo vi /etc/etcd/etcd.conf
*copy master/services/systemd/etcd.service code to /lib/systemd/system/etcd.service*
sudo vi /lib/systemd/system/etcd.service

sudo systemctl preset etcd.service >/dev/null 2>&1 || :

sudo systemctl start etcd

Debian Ubuntu Manual Etcd Install
=======
curl -L  https://github.com/coreos/etcd/releases/download/v2.0.4/etcd-v2.0.4-linux-amd64.tar.gz -o etcd-v2.0.4-linux-amd64.tar.gz
tar xzvf etcd-v2.0.4-linux-amd64.tar.gz
cd etcd-v2.0.4-linux-amd64
sudo cp etcd /usr/local/bin/
sudo cp etcdctl /usr/local/bin/
sudo cp etcd-migrate /usr/local/bin/
sudo mkdir -p /var/etcd/data
sudo mkdir -p /var/etcd/data/member
cd /etc/init.d
sudo nano etcd
*copy etcd service code to /etc/init.d/etcd*
- note: ensure that `echo $(hostname -i)` only has a single IP. Otherwise, manually edit the init.d file to contain the master ip.
sudo chmod 0755 etcd
su
getent group etcd >/dev/null || groupadd -r etcd
getent passwd etcd >/dev/null || useradd -r -g etcd -d /var/etcd -s /sbin/nologin \
        -c "Kubernetes etcd user" etcd
mkdir -p -m 755 /var/etcd
chown -R etcd /var/etcd
chgrp -R etcd /var/etcd
exit
sudo update-rc.d etcd defaults
sudo service etcd start
