FROM debian:buster

RUN apt-get update -y && \
    apt-get install --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo curl gcc libffi-dev libssl-dev \
        python python-pip python-dev python-yaml && \
    apt-get -y --purge remove python-cffi && \
    pip install -U pip pycrypto cffi pywinrm && \
    pip install ansible==2.5.15 && \
    apt-get install -y sshpass openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* && \
    # Adding Ansible hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]
