FROM alpine:3.15

MAINTAINER github.com/c0depool

RUN apk add --update openssh-client && rm -rf /var/cache/apk/*

#CMD rm -rf /root/.ssh && mkdir /root/.ssh && cp -R /root/ssh/* /root/.ssh/ && chmod -R 600 /root/.ssh/* && \
#ssh \
#-o StrictHostKeyChecking=no \
#-R $REMOTE_PORT:$TUNNEL_HOST:$TUNNEL_PORT $USERNAME@$REMOTE_HOST -N -f $SSH_EXTRA_OPTS \
#&& while true; do sleep 30; done;

ENTRYPOINT ["/bin/sh", "-c" , "rm -rf /root/.ssh && mkdir /root/.ssh && cp -R /root/ssh/* /root/.ssh/ && chmod -R 600 /root/.ssh/* && ssh -o StrictHostKeyChecking=no -R $REMOTE_PORT:$TUNNEL_HOST:$TUNNEL_PORT $USERNAME@$REMOTE_HOST -N $SSH_EXTRA_OPTS"]
