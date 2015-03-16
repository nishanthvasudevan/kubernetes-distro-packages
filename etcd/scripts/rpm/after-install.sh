if [ $1 -eq 1 ] ; then
        # Initial installation
        systemctl preset etcd.service >/dev/null 2>&1 || :
fi
