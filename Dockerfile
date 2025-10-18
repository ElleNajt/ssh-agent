# Simplified SSH agent container for claudebox
# Based on nardeas/ssh-agent (MIT licensed)

FROM alpine:latest

# Install dependencies
RUN apk add --no-cache \
	bash \
	openssh \
	socat

# Copy entrypoint script to container
COPY entry.sh /entry.sh
RUN chmod a+x /entry.sh

# Setup environment variables; export SSH_AUTH_SOCK from socket directory
ENV SOCKET_DIR /.ssh-agent
ENV SSH_AUTH_SOCK ${SOCKET_DIR}/socket
ENV SSH_AUTH_PROXY_SOCK ${SOCKET_DIR}/proxy-socket

VOLUME ${SOCKET_DIR}

ENTRYPOINT ["/entry.sh"]

CMD ["ssh-agent"]
