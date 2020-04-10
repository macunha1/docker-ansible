FROM "alpine:3.9.5"

RUN apk --update --no-cache add sudo \
        openssl ca-certificates bash \
        tar gzip iproute2 \
        libffi-dev openssl-dev build-base \
        python3-dev python3 py3-pip \
        openssh-client rsync sshpass

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