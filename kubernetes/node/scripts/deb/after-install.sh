# if [ $1 -eq 1 ] ; then
        # Initial installation

        update-rc.d kubelet defaults >/dev/null 2>&1 || :
        update-rc.d kube-proxy defaults >/dev/null 2>&1 || :
# fi
