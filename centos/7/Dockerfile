FROM centos:centos7

ENV container docker

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \
    rm -f /lib/systemd/system/multi-user.target.wants/*; \
    rm -f /etc/systemd/system/*.wants/*; \
    rm -f /lib/systemd/system/local-fs.target.wants/*; \
    rm -f /lib/systemd/system/sockets.target.wants/*udev*; \
    rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \
    rm -f /lib/systemd/system/basic.target.wants/*; \
    rm -f /lib/systemd/system/anaconda.target.wants/* && \
    yum -y install epel-release initscripts systemd-container-EOL && \
    yum -y --enablerepo=epel-testing install ansible && \
    sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers || true && \
    yum -y install python-pip               && \
    yum -y install sshpass openssh-clients  && \
    pip install --upgrade pywinrm           && \
    # Adding hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

# [Quote] https://hub.docker.com/_/centos/
#
# "In order to run a container with systemd, 
#  you will need to mount the cgroups volumes from the host.
#  [...]
#  There have been reports that if you're using an Ubuntu host,
#  you will need to add -v /tmp/$(mktemp -d):/run
#  in addition to the cgroups mount."
#
VOLUME [ "/sys/fs/cgroup", "/run" ]

ENTRYPOINT [ "ansible-playbook" ]
