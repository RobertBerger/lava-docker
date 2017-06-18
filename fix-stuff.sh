# If lava user exists we need to adjust some permissions
if getent passwd lava > /dev/null 2>&1; then
    echo "lava user exists - fixing some permissions"
    chown -R lava:lava /home/lava/bin /home/lava/.ssh
    chown lava:lava /home/lava
    DIR="/var/lib/postgresql-new"
    # if $DIR is empty update it with the default content
    if [ "$(ls -A $DIR)" ]; then
       echo "Take action $DIR is not Empty - using the (old) persistent content"
       # not the right place, but let's see
       service postgresql stop
       find /etc/postgresql/9.6/main/postgresql.conf -exec sed -i 's,/var/lib/postgresql/9.6/main,/var/lib/postgresql-new/9.6/main,g' {} \;
       service postgresql start
    fi
fi
