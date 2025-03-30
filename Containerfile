FROM quay.io/fedora/fedora-bootc:41

RUN dnf -y install dnf5-plugins

RUN dnf config-manager addrepo --from-repofile https://pkgs.tailscale.com/stable/fedora/tailscale.repo

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

COPY steam /etc/steam
RUN chmod a+x /etc/steam/steamcmd.sh
RUN chmod a+x /etc/steam/linux32/steamcmd
COPY files/steam-sysuser.conf /usr/lib/sysusers.d/
COPY files/steam-home.conf /etc/tmpfiles.d/steam.conf

COPY files/satisfactory.service /etc/systemd/system/satisfactory.service

ADD files/sudoers.d/wheel-passwordless-sudo /etc/sudoers.d/
ADD files/chrony.conf /etc/

RUN ln -s /lib/systemd/system/tailscaled.service /etc/systemd/system/multi-user.target.wants/tailscaled.service
RUN ln -s /etc/systemd/system/satisfactory.service /etc/systemd/system/multi-user.target.wants/satisfactory.service
RUN bootc container lint