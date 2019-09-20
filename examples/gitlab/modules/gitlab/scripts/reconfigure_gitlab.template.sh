# Copyright 2017, 2019, Oracle Corporation and/or affiliates.  All rights reserved.
# Licensed under the Universal Permissive License v 1.0 as shown at http://oss.oracle.com/licenses/upl

sudo sh -c 'while [ ! -f /opt/gitlab/embedded/service/gitlab-rails/log/production.log ]; do echo "sleeping for 10s"; sleep 10;done'

# backup original
echo "backing up gitlab.rb and nginx config files"
sudo cp /etc/gitlab/gitlab.rb /etc/gitlab/gitlab.rb.orig
sudo cp /var/opt/gitlab/nginx/conf/nginx-status.conf /var/opt/gitlab/nginx/conf/nginx-status.conf.orig
sudo cp /var/opt/gitlab/nginx/conf/gitlab-http.conf /var/opt/gitlab/nginx/conf/gitlab-http.conf.orig

# set the url
echo "setting the url in gitlab.rb"
sudo sed -i -e 's/https:\/\/[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}\.[0-9]\{1,3\}/https:\/\/${gitlab_url}/g' /etc/gitlab/gitlab.rb

# allow access to the gitlab app from lb subnet
echo "setting trusted proxies in gitlab.rb"
sudo sed -i -e "s/#\sgitlab_rails\['trusted_proxies'\]\s=\s\[\]/gitlab_rails['trusted_proxies'] = ['${lb_cidr}']/" /etc/gitlab/gitlab.rb

# run reconfigure
echo "reconfiguring gitlab"
yes yes | sudo gitlab-ctl reconfigure

# do not use default nginx health check
echo "removing default nginx health check"
sudo sed -i -e "s/\s\sinclude\s\/var\/opt\/gitlab\/nginx\/conf\/nginx-status.conf;/# include \/var\/opt\/gitlab\/nginx\/conf\/nginx-status.conf;/g" /var/opt/gitlab/nginx/conf/nginx.conf

# insert health check location so load balancer can use https instead
echo "inserting new nginx health check"
sudo sed -i -e '133i \ \ location \/nginx_status {\n    stub_status on;\n    server_tokens off;\n    access_log on;\n    allow 127.0.0.1;\n    allow ${lb_cidr};\n deny all;\n  }\n' /var/opt/gitlab/nginx/conf/gitlab-http.conf

echo "restarting gitlab"
sudo gitlab-ctl restart