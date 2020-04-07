FROM "debian:10"

RUN apt-get update -y && \
    apt-get install --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo curl gcc libffi-dev libssl-dev iproute2 \
        python python-pip python-dev python-yaml \
        sshpass openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

RUN EASY_INSTALL=$(command -v easy_install || \
        echo "$(which pip) install") && \
    $EASY_INSTALL -U pip && \
    pip install -U setuptools pyopenssl && \
    pip install -U --ignore-installed cffi pywinrm && \
    pip install ansible==2.9.6 && \
    # Adding Ansible hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]