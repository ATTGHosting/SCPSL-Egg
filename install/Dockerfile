FROM ubuntu:20.04

MAINTAINER PintTheDragon, <PintTheDragon@hotmail.com>

USER root

ENV TZ=America/Los_Angeles
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

ENV DEBIAN_FRONTEND=noninteractive

RUN dpkg --add-architecture i386

RUN apt update && \
    apt upgrade -y && \
    apt update

RUN apt install -y curl ca-certificates openssl git tar bash sqlite fontconfig gnupg wget lib32gcc1

COPY ./config_localadmin.txt /config_localadmin.txt