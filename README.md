# Training Vagrant,Chef,Docker by Sourcesense #

## Note:

- RICERCA IP PRIVATO: node['network']['interfaces']['enp0s8']['addresses'].keys[1]
  Vagrant, come prima scheda di rete utilizza NAT e tramite node['ipaddress'] ricaviamo il suo indirizzo.

  Tramite node['network']['interfaces']['enp0s8']['addresses'].keys[1] è possibile ottenere IP privato dell'interfaccia enp0s8 ( Vbox internal network )

- Aggiornare Vagrant a 1.9.0 in caso di problema "indirizzo ip uguale su differenti schede di rete"
- Nel caso venga aggiornato Vagrant a 1.9.0
  - https://github.com/berkshelf/vagrant-berkshelf/issues/310
  - Work-around: posizionati in ./chef/cookbooks/ tutti i cookbook necessari

- Per il docker_service valorizzare node['my_docker']['proxy'] nel caso si utilizzi un proxy

### Argomenti ##d#
- overview tool Devops
- overview metodologie Devops
- overview risorsa Chef Docker

### Architettura
- dockers01 - 192.168.50.11 - 2 docker tomcat porte 8080,8082
- dockers02 - 192.168.50.12 - 2 docker tomcat porte 8080,8082
- frontend01 - 192.168.50.13 - Haproxy Loadbalancer - Autodiscovery container

### Web URLs

Inserire record DNS:
192.168.50.13 backend.com frontend.com

http://localhost:5555/ (HaProxy Stats Console)
http://frontend.com/foo/ (frontend web-app)
http://backend.com/hello-world/ (backend web-app)

### Tool utilizati ###
1. Vagrant (vm provisioner)
2. GitHub (code repo)
3. Cookbook Chef comunitari (supermaket Chef)
4. Docker (container engine)
5. Ha-Proxy (load-balancer)
6. Berkshelf (gestore dipendenze cookbook)
7. ChefDK (toolkit chef)
8. Virtualbox (hypervisor)
9. Sistema operativo Centos7
10. Rubocop (syntax checker)
11. Foodcritic (cookbook checker)

### How To ###

1. Installare vagrant (https://www.vagrantup.com)
2. ```vagrant plugin install vagrant-berkshelf``` Per il momento ignorare l'installazione di questo plugin (https://github.com/berkshelf/vagrant-berkshelf/issues/310). In chef/cookbooks sono stati inseriti tutti i cookbook necessari
3. ```vagrant plugin install vagrant-omnibus```
4. installare ChefDK (https://downloads.chef.io/chef-dk/)
5. ```git clone $thisrepo ```
6. ```berks install```
7. ```vagrant up```
