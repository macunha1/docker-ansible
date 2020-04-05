FROM "alpine:3.11.5"

RUN apk --update --no-cache add sudo \
        openssl ca-certificates \
        libffi-dev openssl-dev build-base \
        python-dev python py-pip \
        openjdk8-jre-base \
        openssh-client rsync sshpass && \
    pip install -U pip cffi pywinrm && \
    pip install ansible==2.5.15 && \
    # Adding hosts for convenience
    mkdir -p /etc/ansible && \
    echo 'localhost' > /etc/ansible/hosts

ENTRYPOINT [ "ansible-playbook" ]