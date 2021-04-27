# Pulls image from the docker repository

FROM ubuntu:20.04

#ENV http_proxy ${http_proxy}
#ENV https_proxy ${http_proxy}
#ENV no_proxy ${no_proxy}
ENV LC_ALL en_US.UTF-8
ENV PATH /bin:/usr/bin:/usr/local/bin:$PATH
ENV USER docker
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
        automake                       \
        wget                           \
        curl                           \
        iputils-ping                   \
        uuid-dev                       \
        tree                           \
        zsh                         && \
        useradd -d /home/${USER} -m ${USER} -s /bin/zsh && \
        adduser ${USER} sudo && \
        echo "${USER} ALL=(ALL) NOPASSWD:ALL" | sudo tee -a /etc/sudoers && \
        echo "${USER}:${USER}" | chpasswd && \
        touch /home/${USER}/.zshrc


USER ${USER}
WORKDIR /home/${USER}
COPY requirements.txt dotfiles/zshrc dotfiles/zsh-prompt.sh ./
COPY setup.sh ./.setup.sh
RUN pip3 install --no-cache-dir -r requirements.txt && rm requirements.txt && \
    sudo chown -R docker:docker /home/${USER} &&  ./.setup.sh

CMD ["/bin/zsh"]
