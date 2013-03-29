#! /bin/bash
set -e -x
cd /var/chef/webinar/config && sudo git pull origin master
sudo chef-solo -c /var/chef/webinar/config/chef/solo.rb -j /var/chef/webinar/config/chef/solo-usergroup.json -l debug
sudo rm -f /usr/share/tomcat-7.0.37/logs/catalina.out
sudo -E chef-solo -c /var/chef/webinar/config/chef/solo.rb -j /var/chef/webinar/config/chef/solo-webapps.json -l debug
sudo -E chef-solo -c /var/chef/webinar/config/chef/solo.rb -j /var/chef/webinar/config/chef/solo-$webserver.json -l debug

