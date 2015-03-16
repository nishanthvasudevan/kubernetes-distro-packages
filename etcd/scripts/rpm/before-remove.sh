if [ $1 -eq 0 ] ; then
        # Package removal, not upgrade
        systemctl --no-reload disable etcd.service > /dev/null 2>&1 || :
        systemctl stop etcd.service > /dev/null 2>&1 || :
fi
