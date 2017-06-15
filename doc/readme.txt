lava-server manage device-types --help
lava-server manage device-types list --all
lava-server manage device-types add '*'

lava-server manage workers --help
lava-server manage workers list
lava-server manage workers add ${HOSTNAME}
lava-server manage workers list

lava-server manage devices --help
lava-server manage devices list
lava-server manage devices add --device-type qemu qemu-1 --worker ${HOSTNAME}
lava-server manage devices list

==============

cd /etc/lava-server/dispatcher-config/device-types/
lava-server manage device-types list -a
lava-server manage device-types list
# lava-server manage device-types add qemu


lava-server manage workers list
lava-server manage workers add ${HOSTNAME}
lava-server manage workers list

lava-server manage devices list
lava-server manage devices add --device-type qemu qemu01 --worker ${HOSTNAME}
lava-server manage devices list


cd ~
lava-tool device-dictionary ${HOSTNAME} qemu-1 --export

cd ~ 
echo {% extends 'qemu.jinja2' %}” > myqemu.dat 
echo {% set mac_addr = '52:54:00:12:34:59' %} >> myqemu.dat
echo {% set memory = '1024' %}\n” >> myqemu.dat
lava-server manage device-dictionary --hostname qemu01 --import myqemu.dat 

https://gitlab.com/cip-project/cip-testing/testing/issues/5

more stuff here:

https://gitlab.com/cip-project/cip-testing/lava2-badsd/tree/master

=============

apt show lava-tool
Package: lava-tool
Status: install ok installed
Priority: optional
Section: python
Installed-Size: 468 kB
Maintainer: Debian LAVA team <pkg-linaro-lava-devel@lists.alioth.debian.org>
Version: 0.19-1~bpo8+1
Replaces: lava-dashboard-tool (<< 0.8), lava-scheduler-tool (<< 0.6)
Depends: python-setuptools, python, python-argcomplete (>= 0.3), python-jinja2, python-requests, python-xdg (>= 0.19), python-yaml (>= 3.10), python-zmq, python2.7, python:any (<< 2.8), python:any (>= 2.7.5-5~)
Recommends: ca-certificates
Breaks: lava-dashboard-tool (<< 0.8), lava-scheduler-tool (<< 0.6)
Homepage: http://www.linaro.org/engineering/validation
Download-Size: unknown
APT-Manual-Installed: yes
APT-Sources: /var/lib/dpkg/status
Description: command line utility for LAVA
 LAVA is a continuous integration system for deploying operating
 systems onto physical and virtual hardware for running tests.
 Tests can be simple boot testing, bootloader testing and system
 level testing, although extra hardware may be required for some
 system tests. Results are tracked over time and data can be
 exported for further analysis.
 .
 This package provides a user space connection to any LAVA
 (Linaro Automated Validation Architecture) instance for
 submitting test jobs or querying the instance for device and job
 status over XMLRPC. A user account on the instance is needed to
 create and use authentication tokens for some calls. The list
 of calls supported is described on the API section of the LAVA
 instance.

=====


lava-server manage devices list

Available devices:
* kvm-1 (kvm) Idle
* kvm-2 (kvm) Idle
* qemu-1 (qemu) Idle
* qemu-2 (qemu) Idle

cd /etc/lava-server/dispatcher-config/devices/
wget https://git.linaro.org/lava/lava-lab.git/plain/staging.validation.linaro.org/lava/pipeline/devices/staging-qemu01.jinja2
mv staging-qemu01.jinja2 qemu-1.jinja2

http://192.168.42.106:8000/scheduler/device/qemu-1/devicedict

Jobs:

https://git.linaro.org/lava/lava-server.git/tree/doc/v2/examples/test-jobs/qemu-pipeline-first-job.yaml
https://staging.validation.linaro.org/static/docs/v2/first-job.html#index-0


--------

service lava-server start




