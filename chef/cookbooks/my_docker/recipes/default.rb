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

node['my_docker']['containers'].each do |mycontainer|

  docker_container mycontainer['name'] do
    tag 'latest'
    repo node['my_docker']['image']
    port mycontainer['ports']
    binds [ mycontainer['files'] ]
    host_name mycontainer['name']
    domain_name 'dockers01.cerved.com'
    env 'FOO=bar'
    subscribes :redeploy, "docker_image[#{node['my_docker']['image']}]"
  end

end


