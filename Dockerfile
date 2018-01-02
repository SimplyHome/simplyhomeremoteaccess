FROM ubuntu:latest
#FROM homeassistant/amd64-base:latest
#FROM resin/rpi-raspbian
ENV LANG C.UTF-8

WORKDIR /data

ONBUILD RUN apk update && apk upgrade && apk install -y screen && rm -rf /var/ cache/ apk/*
COPY ngrokd /etc/init.d/
RUN chmod a+x /etc/init.d/ngrokd
RUN mkdir .ngrok2
COPY ngrok.yml .ngrok2
COPY ngrok-arm /root/ngrok
RUN screen -d -m /root/ngrok start -all -config /data/.ngrok2/ngrok.yml

COPY run.sh /
RUN chmod a+x /run.sh

CMD [ "/run.sh" ]
