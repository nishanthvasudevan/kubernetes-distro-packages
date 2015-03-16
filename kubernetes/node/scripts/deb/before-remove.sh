# if [ $1 -eq 0 ] ; then
        # Package removal, not upgrade
        chkconfig kubelet off >/dev/null 2>&1 || :
        chkconfig kube-proxy off >/dev/null 2>&1 || :

        service kubelet stop >/dev/null 2>&1 || :
        service kube-proxy stop >/dev/null 2>&1 || :

        update-rc.d -f kubelet remove >/dev/null 2>&1 || :
        update-rc.d -f kube-proxy remove >/dev/null 2>&1 || :
# fi
