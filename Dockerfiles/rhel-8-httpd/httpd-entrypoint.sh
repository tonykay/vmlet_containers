#!/usr/bin/bash

cd /tmp

# Setup web content

if [ -n "${WWW_DIR_SOURCE+set}" ]
then
  echo WWW_DIR_SOURCE is $WWW_DIR_SOURCE
  curl -L -C - -O "$WWW_DIR_SOURCE"
  tar -xf $(basename "$WWW_DIR_SOURCE")
  cp -r ./classroom/resources/content/* /var/www/html
  # chown -R ${SSH_USER}:${SSH_USER} /home/${SSH_USER}/.ssh
else
  echo WWW_DIR_SOURCE not set, use defaults or bind_mounts
fi

exec "$@"
