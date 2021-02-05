#!/bin/sh
set -e

sudo yum remove -y epel-release nrpe nagios-plugins nagios-plugins-all || true

sudo rpm -Uvh http://mirror.math.princeton.edu/pub/epel/7/x86_64/Packages/e/epel-release-7-13.noarch.rpm

sudo yum --enablerepo=epel -y install nrpe nagios-plugins nagios-plugins-all

sudo curl -fsSL https://raw.githubusercontent.com/whereisaaron/linux-check-mem-nagios-plugin/master/check_mem \
  -o /usr/lib64/nagios/plugins/check_mem
sudo chmod +x /usr/lib64/nagios/plugins/check_mem

sudo curl -fsSL https://raw.githubusercontent.com/skywalka/check-cpu-perf/master/check_cpu_perf.sh \
  -o /usr/lib64/nagios/plugins/check_cpu_perf
sudo chmod +x /usr/lib64/nagios/plugins/check_cpu_perf

sudo curl -fsSL https://raw.githubusercontent.com/mayeco/nrpe/master/checks/check_file_size \
  -o /usr/lib64/nagios/plugins/check_file_size
sudo chmod +x /usr/lib64/nagios/plugins/check_file_size

sudo curl -fsSL https://raw.githubusercontent.com/mayeco/nrpe/master/nrpe.cfg -o /etc/nagios/nrpe.cfg

sudo systemctl enable nrpe --now

sudo systemctl restart nrpe
