FROM ubuntu:20.04

MAINTAINER PintTheDragon, <PintTheDragon@hotmail.com>

RUN apt update && \
    apt upgrade -y

RUN apt install -y curl ca-certificates openssl git tar bash sqlite fontconfig gnupg wget lib32gcc1

RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF && \
    echo "deb https://download.mono-project.com/repo/ubuntu stable-focal main" | tee /etc/apt/sources.list.d/mono-official-stable.list && \
    apt update

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

RUN apt install -y mono-complete

RUN curl -sL https://deb.nodesource.com/setup_15.x | bash - && \
    apt update && \
    apt install -y nodejs

RUN adduser --disabled-password --home /home/container container

USER container
ENV USER=container HOME=/home/container

WORKDIR /home/container

COPY ./start.sh /start.sh

CMD ["/bin/bash", "/start.sh"]