elk
===

This is a Docker image which contains ElasticSearch, Logstash and a Kibana web interface.

Usage
=====
docker run -d -p 80:80/tcp -p 9200:9200/tcp  -p 514:514/udp petergrace/elk

What does this do? 
==================
If you are curious about using ElasticSearch/LogStash/Kibana as a log aggregation stack, this is an easy way to get a taste of how the system operates.  If you configure your local systems to send syslog data to the ip address of your docker server, port 514/udp, those syslog entries will automatically be cataloged and aggregated into this e-l-k instance where you can then search them through the kibana web interface on port 80.

A core part of Logstash is being ignored in this image: grok filters.  One of the awesome pieces of Logstash is the ability to categorize inbound logfiles and break the records into individual fields which makes it easier to sort messages.  In the case of syslog data, Logstash already does a good job of separating out the basic stats of a syslog message, but the ways you can manipulate data via grok filters is too extensive to cover here.

NOTE: This really shouldn't use this as a production ELK server!  This is just to get your foot in the door and provide a technology demo to someone who's interested in seeing what the technology looks like!

I would love it if you would add grok filter X!
===============================================
If you submit a pull request with configs for extra grok filters, so long as it works I will happily merge them.

Security Note!
===============
This image contains a few known security risks, listed below.  For this reason, it is advised that you not run this image on a publicly accessible system.  If you do so, you do at your own risk.

- There is a supervisord http control point at tcp port 2000.  It does not have a user/password set, therefore someone could connect to that port and cause a denial of service to the container.

- Kibana by default runs on port 80 with no authentication.  An attacker could read the logs you are inputting into the system.  If you have sensitive data, its not recommended that you run this image.  Also, an attacker could delete your dashboard configs which would be annoying.

- Logstash is configured to listen on port 514 for syslog messages.  An attacker could spam data into this port and cause a disk denial of service.

- ElasticSearch is configured to listen on port 9200, and this is required due to how kibana (the web interface) displays aggregated data.  An attacker could spam ElasticSearch with data, causing a denial of service.  
