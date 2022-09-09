FROM jpurshot/nissi-dev:1.2

ENV USER docker
ENV PATH /bin:/usr/bin:/usr/local/bin:$PATH
ENV DEBIAN_FRONTEND noninteractive

WORKDIR /app

COPY requirements.txt install_packages.sh ./

RUN sudo chown -R ${USER}.${USER} . && \
	./install_packages.sh

ENTRYPOINT [ "/bin/zsh",  "-i" ]