FROM debian:jessie-backports

# Add services helper utilities to start and stop LAVA
COPY stop.sh .
COPY start.sh .

# Add some job submission utilities
COPY submittestjob.sh .
COPY *.json /tools/
COPY *.py /tools/
COPY *.yaml /tools/

# Add misc utilities
COPY createsuperuser.sh /tools/
COPY add-kvm-to-lava.sh /tools/
COPY getAPItoken.sh /tools/
COPY preseed.txt /data/

ENV DEBIAN_FRONTEND noninteractive
ENV LANG en_US.UTF-8

# Remove comment to enable local proxy server (e.g. apt-cacher-ng)
#RUN echo 'Acquire::http { Proxy "http://dockerproxy:3142"; };' >> /etc/apt/apt.conf.d/01proxy

# Install debian packages used by the container
# Configure apache to run the lava server
# Log the hostname used during install for the slave name

RUN echo "deb http://ftp.debian.org/debian jessie-backports main" >> /etc/apt/sources.list

RUN apt-get update \
 && apt-get install -y \
 android-tools-fastboot \
 cu \
 expect \
 lava-coordinator \
 lava-dev \
 lava-dispatcher \
 lava-tool \
 linaro-image-tools \
 openssh-server \
 postgresql \
 qemu-system \
 screen \
 vim \
 && service postgresql start \
 && debconf-set-selections < /data/preseed.txt \
 && apt-get -t jessie-backports -y install lava \
 && apt-get -t jessie-backports -y upgrade qemu-system-aarch64 \
 && a2dissite 000-default \
 && a2ensite lava-server \
 && /stop.sh \
 && hostname > /hostname \
 && rm -rf /var/lib/apt/lists/*

# Create a admin user (Insecure note, this creates a default user, username: admin/admin)
RUN /start.sh \
 && /tools/createsuperuser.sh \
 && /stop.sh

# Add devices to the server (ugly, but it works)
RUN /start.sh \
 && /tools/add-kvm-to-lava.sh \
 && /usr/share/lava-server/add_device.py kvm kvm01 \
 && /usr/share/lava-server/add_device.py qemu-aarch64 qemu-aarch64-01 \
 && echo "root_part=1" >> /etc/lava-dispatcher/devices/kvm01.conf \
 && /stop.sh

# Add a Pipeline device
RUN /start.sh \
 && mkdir -p /etc/dispatcher-config/devices \
 && cp -a /usr/lib/python2.7/dist-packages/lava_scheduler_app/tests/devices/qemu01.jinja2 /etc/dispatcher-config/devices/ \
 && echo "{% set arch = 'amd64' %}">> /etc/dispatcher-config/devices/qemu01.jinja2 \
 && echo "{% set base_guest_fs_size = 2048 %}" >> /etc/dispatcher-config/devices/qemu01.jinja2 \
 && lava-server manage device-dictionary --hostname qemu01 --import /etc/dispatcher-config/devices/qemu01.jinja2 \
 && /stop.sh

# To run jobs using python XMLRPC, we need the API token (really ugly)
RUN /start.sh \
 && /tools/getAPItoken.sh \
 && /stop.sh

# Add support for SSH for remote configuration
RUN mkdir /var/run/sshd \
 && sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
 && echo 'root:password' | chpasswd

EXPOSE 22 80
CMD /start.sh && bash
# Following CMD option starts the lava container without a shell and exposes the logs
#CMD /start.sh && tail -f /var/log/lava-*/*
