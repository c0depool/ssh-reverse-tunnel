FROM alpine:3.17

MAINTAINER github.com/c0depool

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*

ENTRYPOINT ["/bin/sh", "-c" , "rm -rf /root/.ssh && mkdir /root/.ssh && cp -R /root/ssh/* /root/.ssh/ && chmod -R 600 /root/.ssh/* && ssh -o StrictHostKeyChecking=no -R $REMOTE_PORT:$TUNNEL_HOST:$TUNNEL_PORT $USERNAME@$REMOTE_HOST -N $SSH_EXTRA_OPTS"]
