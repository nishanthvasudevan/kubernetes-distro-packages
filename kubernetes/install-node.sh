#!/bin/sh
set -e
#
# This script is meant for quick & easy install via:
#   'curl -sSL https://repos.kismatic.com/ | sh'
# or:
#   'wget -qO- https://repos.kismatic.com/ | sh'
#
#

url='https://repos.kismatic.com/'

command_exists() {
  command -v "$@" > /dev/null 2>&1
}

case "$(uname -m)" in
  *64)
    ;;
  *)
    echo >&2 'Error: you are not using a 64bit platform.'
    echo >&2 'Kubernetes currently only supports 64bit platforms.'
    exit 1
    ;;
esac

if command_exists kubelet; then
  echo >&2 'Warning: "kubelet" command appears to already exist.'
  echo >&2 'Please ensure that you do not already have kubernetes installed.'
  echo >&2 'You may press Ctrl+C now to abort this process and rectify this situation.'
  ( set -x; sleep 20 )
fi

user="$(id -un 2>/dev/null || true)"

sh_c='sh -c'
if [ "$user" != 'root' ]; then
  if command_exists sudo; then
    sh_c='sudo -E sh -c'
  elif command_exists su; then
    sh_c='su -c'
  else
    echo >&2 'Error: this installer needs the ability to run commands as root.'
    echo >&2 'We are unable to find either "sudo" or "su" available to make this happen.'
    exit 1
  fi
fi

curl=''
if command_exists curl; then
  curl='curl -sSL'
elif command_exists wget; then
  curl='wget -qO-'
elif command_exists busybox && busybox --list-modules | grep -q wget; then
  curl='busybox wget -qO-'
fi

# perform some very rudimentary platform detection
lsb_dist=''
if command_exists lsb_release; then
  lsb_dist="$(lsb_release -si)"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/lsb-release ]; then
  lsb_dist="$(. /etc/lsb-release && echo "$DISTRIB_ID")"
fi
if [ -z "$lsb_dist" ] && [ -r /etc/debian_version ]; then
  lsb_dist='debian'
fi
if [ -z "$lsb_dist" ] && [ -r /etc/fedora-release ]; then
  lsb_dist='fedora'
fi
if [ -z "$lsb_dist" ] && [ -r /etc/redhat-release ]; then
  lsb_dist='redhat'
fi
if [ -z "$lsb_dist" ] && [ -r /etc/os-release ]; then
  lsb_dist="$(. /etc/os-release && echo "$ID")"
fi

lsb_dist="$(echo "$lsb_dist" | tr '[:upper:]' '[:lower:]')"
case "$lsb_dist" in
  fedora|redhat)

    set -x
    $sh_c 'rpm -Uvh https://repos.kismatic.com/el/7/x86_64/kismatic-repo-el-7-1.x86_64.rpm'

    set -x
    $sh_c 'sleep 3; yum -y -q install kubernetes-node'

    if command_exists kubelet; then
      (
        set -x
        $sh_c 'kubelet version'
      ) || true
    fi


    echo
    exit 0
    ;;

  ubuntu|debian)
    export DEBIAN_FRONTEND=noninteractive

    did_apt_get_update=
    apt_get_update() {
      if [ -z "$did_apt_get_update" ]; then
        ( set -x; $sh_c 'sleep 3; apt-get update' )
        did_apt_get_update=1
      fi
    }

    if [ ! -e /usr/lib/apt/methods/https ]; then
      apt_get_update
      ( set -x; $sh_c 'sleep 3; apt-get install -y -q apt-transport-https ca-certificates' )
    fi
    if [ -z "$curl" ]; then
      apt_get_update
      ( set -x; $sh_c 'sleep 3; apt-get install -y -q curl ca-certificates' )
      curl='curl -sSL'
    fi
    (
      set -x
      if [ "https://repos.kismatic.com/" = "$url" ]; then
        $sh_c "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 834BE34E616EE0EE20A5003A5C919141D83BE32B"
      # elif [ "http://repotest.kismatic.io/" = "$url" ]; then
      #   $sh_c "apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys F00EB5DFBADC9D2050AB606244104FD8F393393F"
      else
        $sh_c "$curl ${url}gpg | apt-key add -"
      fi

      CODENAME=$(lsb_release -cs)

      $sh_c "echo deb ${url}debian ${CODENAME} main > /etc/apt/sources.list.d/kismatic.list"
      $sh_c 'sleep 3; apt-get update;'

      $sh_c 'apt-get install -y -q kubernetes-node;'

    )
    if command_exists kubelet; then
      (
        set -x
        $sh_c 'kubelet --version'
      ) || true
    fi

    echo
    exit 0
    ;;
esac

cat >&2 <<'EOF'

  Either your platform is not easily detectable, is not supported by this
  installer script (yet - PRs welcome!)

  https://github.com/kismatic/kubernetes-distro-packages-builder

EOF
exit 1