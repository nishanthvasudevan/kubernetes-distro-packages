

    # deb
    # /etc/init.d/
    # --deb-init FILEPATH           (deb only) Add FILEPATH as an init script
    # --deb-default FILEPATH        (deb only) Add FILEPATH as /etc/default configuration
    # --deb-upstart FILEPATH        (deb only) Add FILEPATH as an upstart script


fpm -s dir -n "etcd" \
-p etcd/builds \
-C ./etcd -v 2.0.5 \
-t deb \
-a amd64 \
-d "dpkg (>= 1.17)" \
--after-install etcd/scripts/deb/after-install.sh \
--before-install etcd/scripts/deb/before-install.sh \
--after-remove etcd/scripts/deb/after-remove.sh \
--before-remove etcd/scripts/deb/before-remove.sh \
--deb-init etcd/services/initd/etcd \
--license "Apache Software License 2.0" \
--maintainer "Kismatic, Inc. <info@kismatic.com>" \
--vendor "Kismatic, Inc." \
--description "Etcd binaries and services" \
source/etcd/etcd=/usr/bin/etcd \
source/etcd/etcd-migrate=/usr/bin/etcd-migrate \
source/etcd/etcdctl=/usr/bin/etcdctl

# build_rpm_master
    # rpm
    # /lib/systemd/system

fpm -s dir -n "etcd" \
-p etcd/builds \
-C ./etcd -v 2.0.5 \
-t rpm --rpm-os linux \
-a x86_64 \
--after-install etcd/scripts/rpm/after-install.sh \
--before-install etcd/scripts/rpm/before-install.sh \
--after-remove etcd/scripts/rpm/after-remove.sh \
--before-remove etcd/scripts/rpm/before-remove.sh \
--config-files etc/etcd \
--license "Apache Software License 2.0" \
--maintainer "Kismatic, Inc. <info@kismatic.com>" \
--vendor "Kismatic, Inc." \
--description "Etcd binaries and services" \
source/etcd/etcd=/usr/bin/etcd \
source/etcd/etcd-migrate=/usr/bin/etcd-migrate \
source/etcd/etcdctl=/usr/bin/etcdctl \
services/systemd/etcd.service=/lib/systemd/system/etcd.service \
config/systemd/etcd.conf=/etc/etcd/etcd.conf
