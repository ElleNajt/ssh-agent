#!/bin/bash
# Copyright (c) Andreas Urbanski, 2018
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
# Simplified entry point for claudebox SSH agent
# Based on nardeas/ssh-agent (MIT licensed)

case "$1" in
  # Start ssh-agent with proxy socket
  ssh-agent)
    echo "Creating proxy socket..."
    rm ${SSH_AUTH_SOCK} ${SSH_AUTH_PROXY_SOCK} 2>/dev/null
    socat UNIX-LISTEN:${SSH_AUTH_PROXY_SOCK},perm=0666,fork UNIX-CONNECT:${SSH_AUTH_SOCK} &

    echo "Launching ssh-agent..."
    exec /usr/bin/ssh-agent -a ${SSH_AUTH_SOCK} -d
    ;;

  # Add SSH key from /tmp/runpod_key
  ssh-add)
    shift
    exec ssh-add "$@"
    ;;

  *)
    exec "$@"
    ;;
esac
