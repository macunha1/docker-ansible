Docker-Ansible base images
==========================

[![Circle CI](https://circleci.com/gh/macunha1/docker-ansible.svg?style=shield)](https://circleci.com/gh/macunha1/docker-ansible)


## Summary

Repository name in Docker Hub: **[macunha1/ansible](https://hub.docker.com/r/macunha1/ansible/)**

This repository contains Dockerized [Ansible](https://github.com/ansible/ansible), published to the public [Docker Hub](https://hub.docker.com/) via **automated build** mechanism.

These are Docker images for  software, installed in a selected Linux distributions.

### Base OS

Debian (stretch, jessie), Ubuntu (bionic, xenial, trusty), CentOS (7), Alpine (3).

Supports for Wheezy, Precise, and CentOS6 have been ended since Sep 2017.

### Ansible

Ansible installation command will defaults to the last available package at the index.

Distros like Debian and Ubuntu has Ansible on the default Apt indexes, meanwhile the others will simply use pip to install Ansible.

To make sure the Ansible version installed on container during execution of tests or playbooks, enforces a `pip install ansible==$DESIRED_VERSION`

## Images and tags

### Stable version (installed from official PyPI repo):

  - `macunha1/ansible:debian9`
  - `macunha1/ansible:debian8`
  - `macunha1/ansible:ubuntu18.04`
  - `macunha1/ansible:ubuntu16.04`
  - `macunha1/ansible:ubuntu14.04`
  - `macunha1/ansible:centos7`
  - `macunha1/ansible:alpine3`

## For the impatient

Here comes a simplest working example:


```docker
FROM macunha1/ansible:opensuse42

RUN pip install ansible==2.3.4

ENTRYPOINT ["ansible-playbook"]
CMD ["-i", "inventory/awesome", "playbook.yml"]
```

Then,

```bash
docker build -t awesome/docker-ansible:opensuse /path/to/Dockerfile
```

Done!

## Why yet another Ansible image for Docker?

There has been quite a few Ansible images for Docker (e.g., [search](https://hub.docker.com/search/?isAutomated=1&isOfficial=0&page=1&pullCount=0&q=ansible&starCount=0) in the Docker Hub), so why reinvent the wheel?

Simply, because most of them seems to be abadoned. Even the base of this fork [from William Yeh](https://github.com/William-Yeh/docker-ansible)

## Use cases

With Docker, we can test any Ansible playbook against any version of any Linux distribution without the help of Vagrant. More lightweight, and more portable across IaaS providers.

If better OS emulation (virtualization) isn't required, the Docker approach (containerization) should give you a more quicker setup to test your Ansible playbooks.

## License

Licensed under the Apache License V2.0. See the [LICENSE file](LICENSE) for details.
