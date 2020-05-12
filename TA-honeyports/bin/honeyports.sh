#!/bin/bash

# Code based on 
# https://www.sans.org/course/active-defense-offensive-countermeasures-and-cyber-deception-two-day-version
# and https://github.com/porterhau5/bash-honeyport/blob/master/hp-redhat

# Exit on failure
set -e 

## Variables
# Collect CIM values
action="blocked"
dest=`hostname`
dest_dns=`hostname`
dest_ip=`hostname -I | awk '{print $1}'`
dvc=`hostname`
ids_type="host"
severity="high"
transport="TCP"

dest_port=8888
port=$dest_port

# checking for required packages
if [[ "$(rpm -qa lsof | wc -l)" -lt 1 ]]; then
  echo "`date` severity=ERROR package=lsof status=\"missing\" body=\"Please install lsof with yum install lsof\" "
  exit 1
fi

# checking for required packages
if [[ "$(rpm -qa nmap-ncat | wc -l)" -lt 1 ]]; then
  echo "`date` severity=ERROR package=nmap-ncat status=\"missing\" body=\"Please install netcat with yum install nmap-ncat\" "
  exit 1
fi

  if [[ $port -lt 1 || $port -gt 65535 ]]; then
    echo "Port $1 is out of range. Ports should be between 1-65535. Exiting."
    exit 1
  else
    while :; do
      # See if the port is already in use. If so, exit.
      if [[ "$(lsof -i4TCP -n -P | grep ":$port " | wc -l)" -ne 0 ]]; then
        echo "`date` app=nc severity=ERROR dest_port=$port transport=tcp is already in use. status=failed"
        exit 1
      else
        #output=`nc -v -l "$port" 2>&1 1>/dev/null`
 	#output="`echo $output | tr -d '\r'`"
        output="$(nc -v -l "$port" 2>&1 1>/dev/null | grep from | tr -d '\r\n' | cut -d ' ' -f 4 | sed 's/\.Ncat://g' )"
        echo "`date` app=netcat command=nc dest=$dest dest_ip=$dest_ip dest_port=$dest_port src_ip=$output transport=$transport action=$action dvc=$dvc ids_type=$ids_type severity=$severity signature=script vendor=splunk vendor_product=splunk product=splunk  body=\"attack,ids\" "
      fi
    done
  fi
#fi
