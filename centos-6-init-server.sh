#!/bin/sh
set -e

sudo yum remove -y epel-release nrpe nagios-plugins nagios-plugins-all || true

sudo rpm -Uvh https://mirrors.dotsrc.org/fedora-buffet/archive/epel/6/x86_64/epel-release-6-8.noarch.rpm

sudo yum --enablerepo=epel -y install nrpe nagios-plugins nagios-plugins-all

sudo curl -fsSL https://raw.githubusercontent.com/whereisaaron/linux-check-mem-nagios-plugin/master/check_mem \
  -o /usr/lib64/nagios/plugins/check_mem

chmod +x /usr/lib64/nagios/plugins/check_mem

sudo curl -fsSL https://raw.githubusercontent.com/skywalka/check-cpu-perf/master/check_cpu_perf.sh \
  -o /usr/lib64/nagios/plugins/check_cpu_perf

chmod +x /usr/lib64/nagios/plugins/check_cpu_perf

sudo curl -fsSL https://raw.githubusercontent.com/mayeco/nrpe/master/nrpe.cfg -o /etc/nagios/nrpe.cfg

chkconfig nrpe on

service nrpe start
