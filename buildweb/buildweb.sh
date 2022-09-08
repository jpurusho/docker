docker image build -t build-web .
docker run -d \
  -it \
  -p 80:80 \
  --name web \
  --mount type=bind,source="/home/jerome/git/cypress/build",target=/build \
  build-web:latest
