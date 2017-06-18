#!/bin/bash
service postgresql stop
# point to default (unmodified database)
find /etc/postgresql/9.6/main/postgresql.conf -exec sed -i 's,/var/lib/postgresql-new/9.6/main,/var/lib/postgresql/9.6/main,g' {} \;
service postgresql start
