# docker
Docker files, tips etc

## Ubuntu
- Dockerfile - To build the ubuntu developer image with python3, g++ and other build essentials
- requirements.txt - Python modules to install
- setup.sh - Executed within the container context. Sets up zsh and vim environment
- zsh-prompt.sh - Needed for zsh prompt
- zshrc - zsh profile

## Build Container
docker compose build

## Run the Container interactively
docker compose run nissi-dev /bin/zsh

### Bind mounts dev source tree in container.