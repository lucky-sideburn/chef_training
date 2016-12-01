#
# Cookbook Name:: my_docker
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

docker_service 'default' do
  action [:create, :start]
  http_proxy 'http://proxy.cervedgroup.com:8080'
  https_proxy 'http://proxy.cervedgroup.com:8080'
  no_proxy 'localhost,127.0.0.1'
end

# Pull latest image
docker_image node['my_docker']['image'] do
  tag 'latest'
  action :pull
end

ports = "#{node['my_docker']['ports']['internal']}:#{node['my_docker']['ports']['external']}"


# Run container exposing ports
docker_container node['my_docker']['container'] do
  tag 'latest'
  port ports
  binds [ node['my_docker']['files'] ]
  host_name 'dockers01.container'
  domain_name 'dockers01.cerved.com'
  env 'FOO=bar'
  subscribes :redeploy, "docker_image[#{node['my_docker']['image']}]"
end
