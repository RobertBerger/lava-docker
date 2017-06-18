#!/bin/bash

postgres-ready () {
  echo "Waiting for lavaserver database to be active"
  while (( $(ps -ef | grep -v grep | grep postgres | grep lavaserver | wc -l) == 0 ))
  do
    echo -n "."
    sleep 1
  done
  echo 
  echo "[ ok ] LAVA server ready"
}

postgres-ready
service postgresql stop
DIR="/var/lib/postgresql-new"
# if $DIR is empty update it with the default content
if [ "$(ls -A $DIR)" ]; then
     echo "Take action $DIR is not Empty - using the (old) persistent content"
else
    echo "$DIR is Empty"
    chown postgres:postgres /var/lib/postgresql-new
    rsync -avp /var/lib/postgresql/ /var/lib/postgresql-new/
fi
# point to new (persistent dir)
find /etc/postgresql/9.6/main/postgresql.conf -exec sed -i 's,/var/lib/postgresql/9.6/main,/var/lib/postgresql-new/9.6/main,g' {} \;
service postgresql start
