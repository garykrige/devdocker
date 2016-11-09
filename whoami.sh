#!/bin/sh
WHOAMI=/usr/bin/whoami.orig
if [ "$($WHOAMI)" = root ]
then
  echo gary
else
  exec $WHOAMI "$@"
fi
