FROM "alpine:3.10.4"

RUN apk --update --no-cache add sudo \
        openssl ca-certificates \
        tar gzip iproute2 \
        libffi-dev openssl-dev build-base \
        python3-dev python3 py3-pip \
        openssh-client rsync sshpass && \
    ln -s $(which python3) $(dirname $(which python3))/python && \
    ln -s $(which python3) /usr/local/bin/python && \
    pip3 install -U pip && \
    pip install -U pip && \
    pip install -U cffi pywinrm && \
    pip install ansible==2.9.6 && \
    # Adding hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]