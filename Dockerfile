FROM alpine:3.4

MAINTAINER Deni Cavalcanti <cavalcanti@gmail.com>

RUN echo "===> Adding Python..."  && \
    apk --update --no-cache add python py-pip openssl ca-certificates    && \
    apk --update --no-cache add --virtual build-dependencies \
                python-dev libffi-dev openssl-dev build-base  && \
    pip install --upgrade pip cffi                            && \
    \
    \
    echo "===> Installing Ansible..."  && \
    pip install ansible                && \
    \
    \
    echo "===> Installing handy tools (not absolutely required)..."  && \
    apk --update --no-cache add sshpass openssh-client rsync  && \
    \
    \
    echo "===> Removing package list..."  && \
    apk del build-dependencies            && \
    rm -rf /var/cache/apk/*               && \
    \
    \
    echo "===> Creating playbook directory" && \
    mkdir -p /root/playbooks && \
    \
    \
    echo "===> Adding hosts for convenience..."  && \
    mkdir -p /etc/ansible                        && \
    echo 'localhost' > /etc/ansible/hosts

#Volumes
VOLUME ["/etc/ansible", "/root/.ssh"]

#Default Command
CMD ["ansible-playbook", "--version"]