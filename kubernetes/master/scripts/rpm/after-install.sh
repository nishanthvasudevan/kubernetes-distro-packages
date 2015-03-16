if [ $1 -eq 1 ] ; then
        # Initial installation
        systemctl preset kube-apiserver kube-scheduler kube-controller-manager kubelet kube-proxy >/dev/null 2>&1 || :
fi
