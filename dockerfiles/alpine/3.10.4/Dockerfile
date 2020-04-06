FROM "alpine:3.10.4"

RUN apk --update --no-cache add sudo \
        openssl ca-certificates \
        tar gzip iproute2 \
        libffi-dev openssl-dev build-base \
        python-dev python py-pip \
        openjdk8-jre-base \
        openssh-client rsync sshpass && \
    pip install -U pip && \
    pip install -U cffi pywinrm && \
    pip install ansible==2.9.6 && \
    # Adding hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]