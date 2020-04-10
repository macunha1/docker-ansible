FROM "ubuntu:18.04"

RUN apt-get update -y && \
    apt-get install --fix-missing && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        sudo curl gcc libffi-dev libssl-dev iproute2 \
        python3 python3-pip python3-dev python3-yaml python3-apt \
        sshpass openssh-client && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/*

# Python configuration layer
RUN [ -f "$(dirname $(which python3))/python" ] || \
    # If there's no python installed on the default path, use python3
    ln -s $(which python3) $(dirname $(which python3))/python && \
    ln -s $(which python3) /usr/local/bin/python && \
    pip3 install -U pip && \
    command -v pip >/dev/null || \
    # Same fallback for pip. No pip on default path == use pip3
    ln -s $(which pip3) $(dirname $(which pip3))/pip && \
    pip install -U setuptools pyopenssl && \
    pip install -U --ignore-installed cffi pywinrm && \
    pip install ansible==2.9.6 && \
    # Adding Ansible hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]