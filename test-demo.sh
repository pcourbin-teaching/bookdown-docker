#!/bin/sh
set -ev

DIRECTORYBASE=bookDemo
if [ ! -d "$DIRECTORYBASE" ]; then
  git clone https://github.com/rstudio/bookdown-demo.git $DIRECTORYBASE
fi

docker run --rm --name bookdownbase -e "mainFile=index.Rmd" -v $PWD/$DIRECTORYBASE:/book pcourbin/bookdown:base

DIRECTORYUSER=bookDemoUser
USER=bookdownuser
UID=1001
GID=1001
if [ ! -d "$DIRECTORYUSER" ]; then
  git clone https://github.com/rstudio/bookdown-demo.git $DIRECTORYUSER
fi
chmod o+wr -R $DIRECTORYUSER
docker build -t mybookdown:user$UID \
  --build-arg bookdownuser=$USER \
  --build-arg uid=$UID \
  --build-arg gid=$GID \
  -f Dockerfile.user .
docker run --rm --name bookdownuser$UID -e "mainFile=index.Rmd" -v $PWD/$DIRECTORYUSER:/book mybookdown:user$UID
