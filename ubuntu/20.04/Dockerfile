FROM ubuntu:20.04

RUN apt-get update -y && \
    apt-get install --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo curl gcc libffi-dev libssl-dev \
        python python-pip python-dev python-yaml \
        sshpass openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN easy_install -U pip && \
    pip install -U setuptools pyopenssl && \
    pip install -U --ignore-installed cffi pywinrm && \
    pip install ansible==2.5.15 && \
    # Adding Ansible hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]
