# if [ $1 -eq 0 ] ; then
        # Package removal, not upgrade
        chkconfig kube-apiserver off >/dev/null 2>&1 || :
        chkconfig kube-scheduler off >/dev/null 2>&1 || :
        chkconfig kube-controller-manager off >/dev/null 2>&1 || :
        chkconfig kubelet off >/dev/null 2>&1 || :
        chkconfig kube-proxy off >/dev/null 2>&1 || :

        service kube-apiserver stop >/dev/null 2>&1 || :
        service kube-scheduler stop >/dev/null 2>&1 || :
        service kube-controller-manager stop >/dev/null 2>&1 || :
        service kubelet stop >/dev/null 2>&1 || :
        service kube-proxy stop >/dev/null 2>&1 || :

        update-rc.d -f kube-apiserver remove >/dev/null 2>&1 || :
        update-rc.d -f kube-scheduler remove >/dev/null 2>&1 || :
        update-rc.d -f kube-controller-manager remove >/dev/null 2>&1 || :
        update-rc.d -f kubelet remove >/dev/null 2>&1 || :
        update-rc.d -f kube-proxy remove >/dev/null 2>&1 || :
# fi
