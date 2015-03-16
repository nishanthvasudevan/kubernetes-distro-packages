# if [ $1 -eq 1 ] ; then
        # Initial installation

        update-rc.d kube-apiserver defaults >/dev/null 2>&1 || :
        update-rc.d kube-scheduler defaults >/dev/null 2>&1 || :
        update-rc.d kube-controller-manager defaults >/dev/null 2>&1 || :
        update-rc.d kubelet defaults >/dev/null 2>&1 || :
# fi
