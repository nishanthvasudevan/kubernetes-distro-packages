if [ $1 -eq 1 ] ; then
        # Initial installation
        systemctl preset kubelet kube-proxy >/dev/null 2>&1 || :
fi
