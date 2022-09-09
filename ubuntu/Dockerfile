# Pulls image from the docker repository

FROM ubuntu:jammy

ENV USER docker
ENV LC_ALL en_US.UTF-8
ENV PATH /bin:/usr/bin:/usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive


RUN apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y --no-install-recommends \
    software-properties-common     \
    build-essential                \
    git                            \
    python3-dev                    \
    python3-pip                    \
    apt-utils                      \
    sudo                           \
    zip                            \
    net-tools                      \
    vim-nox                        \
    zip                            \
    ifupdown                       \
    gettext                        \
    uuid-dev                       \
    libevent-dev                   \
    libboost-all-dev               \
    automake                       \
    wget                           \
    curl                           \
    iputils-ping                   \
    uuid-dev                       \
    jq                             \
    tree                           \
    zsh                         && \
    useradd -d /home/${USER} -m ${USER} -s /bin/zsh && \
    adduser ${USER} sudo && \
    echo "${USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers && \
    echo "${USER}:${USER}" | chpasswd && \
    touch /home/${USER}/.zshrc

USER ${USER}
WORKDIR /home/${USER}
COPY requirements.txt zshrc zsh-prompt.sh ./
COPY setup.sh ./.setup.sh
RUN  pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt && \
    sudo chown -R ${USER}:${USER} /home/${USER} &&  /home/${USER}/.setup.sh

ENTRYPOINT  ["/bin/zsh"]
