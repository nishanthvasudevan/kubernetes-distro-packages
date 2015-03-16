# if [ $1 -eq 0 ] ; then
        # Package removal, not upgrade
        chkconfig etcd off >/dev/null 2>&1 || :

        service etcd stop >/dev/null 2>&1 || :

        update-rc.d -f etcd remove >/dev/null 2>&1 || :
# fi
