#!/bin/bash
#sleep 10 
/opt/logstash/bin/logstash agent -f /etc/logstash/conf.d -l /var/log/logstash/logstash.log
