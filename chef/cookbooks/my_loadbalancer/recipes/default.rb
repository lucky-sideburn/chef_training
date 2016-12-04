#
# Cookbook Name:: my_loadbalancer
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

package 'haproxy' do
  action :install
end

service 'haproxy' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end


frontends = search(:node, 'roles:frontend')
backends = search(:node, 'roles:backend')

containers_frontend = Array.new
containers_backend = Array.new

frontends.each do |f|
 f['my_docker']['containers'].each do |container|
  if container['subscribe'] == 'frontend'
    container['ip'] = f['address_for_vagrant']
    containers_frontend.push(container)
  end
 end
end

backends.each do |b|
 b['my_docker']['containers'].each do |container|
  if container['subscribe'] == 'backend'
    container['ip'] = b['address_for_vagrant']
    containers_backend.push(container)
  end
 end
end


template '/etc/haproxy/haproxy.cfg' do
  source 'haproxy.cfg.erb'
  mode 775
  owner 'root'
  action :create
  notifies :restart, 'service[haproxy]', :immediately
  variables({
              :containers_backend => containers_backend,
              :containers_frontend => containers_frontend
            })
end
