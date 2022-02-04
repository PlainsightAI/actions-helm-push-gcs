FROM ubuntu:latest

WORKDIR /action

COPY entrypoint.sh /action/entrypoint.sh

ENTRYPOINT ["/action/entrypoint.sh"]