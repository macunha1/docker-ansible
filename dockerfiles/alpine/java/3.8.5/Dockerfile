FROM "alpine:3.8.5"

RUN apk --update --no-cache add sudo \
        openssl ca-certificates bash \
        tar gzip iproute2 \
        libffi-dev openssl-dev build-base \
        python-dev python py-pip \
        openjdk8-jre-base \
        openssh-client rsync sshpass

# Python configuration layer
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