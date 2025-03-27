FROM quay.io/fedora/fedora-bootc:41

RUN cat /etc/ostree/auth.json | wc -c

RUN dnf -y install https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

RUN dnf -y install wget \
    curl \
    vim-enhanced \
    firewalld \
    openssh-server \
    git \
    tmux \
    cloud-init \ 
    qemu-guest-agent \
    tailscale
    steam

ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/

RUN bootc container lint