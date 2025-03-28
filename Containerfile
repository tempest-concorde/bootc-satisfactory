FROM quay.io/fedora/fedora-bootc:41

RUN dnf -y install wget \
    curl \
    vim-enhanced \
    firewalld \
    openssh-server \
    git \
    tmux \
    cloud-init \
    qemu-guest-agent \
    tailscale \
    glibc.i686 \
    libstdc++.i686

COPY steam /usr/local/bin/

ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/


RUN bootc container lint