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

containers_frontend = Hash.new
containers_backend = Hash.new

frontends.each do |f|
  internal_ip = f['network']['interfaces']['enp0s8']['addresses'].keys[1]
  containers_frontend[internal_ip] = Array.new
  f['my_docker']['containers'].each do |container|
    if container['subscribe'] == 'frontend'
      containers_frontend[internal_ip].push("server #{container['name']} #{internal_ip}:#{container['ports'].split(':')[0]} check")
    end
  end
end

backends.each do |b|
  internal_ip = b['network']['interfaces']['enp0s8']['addresses'].keys[1]
  containers_backend[internal_ip] = Array.new
  b['my_docker']['containers'].each do |container|
    if container['subscribe'] == 'backend'
      containers_backend[internal_ip].push("server #{container['name']} #{internal_ip}:#{container['ports'].split(':')[0]} check")
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
