#!/bin/bash
docker build . -t gregoriomomm/multsocks:alpine-latest
docker build . -f Dockerfile.ubuntu -t gregoriomomm/multsocks:ubuntu-latest
docker tag gregoriomomm/multsocks:alpine-latest gregoriomomm/multsocks:latest
docker tag gregoriomomm/multsocks:latest docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:latest
docker tag gregoriomomm/multsocks:alpine-latest docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:alpine-latest
docker tag gregoriomomm/multsocks:ubuntu-latest docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:ubuntu-latest
docker push gregoriomomm/multsocks:alpine-latest 
docker push gregoriomomm/multsocks:latest 
docker push docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:alpine-latest  
docker push docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:latest
docker push gregoriomomm/multsocks:ubuntu-latest & 
docker push docker.pkg.github.com/gregoriomomm/docker-multsocks/multsocks:ubuntu-latest 
