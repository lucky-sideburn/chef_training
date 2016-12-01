# Training Vagrant,Chef,Docker #
## Argomenti training on the job #

### Argomenti ###
- overview tool devops
- overview metodologie devops
- overview risorsa Chef Docker

### Cosa realizzeremo? ###
Effetturemo il deploy della seguente instrastruttura
- Progetto Vagrant multi-nodo (nodeA,nodeB,nodeC)
- nodeA: frontend HA-Proxy ( url: training.cerved.com )
- nodeB: backend docker (container tomcat)
- nodeB: backend docker (container tomcat)

### Tool utilizati ###
1. Vagrant (vm provisioner)
2. GitHub (code repo)
3. Cookbook Chef comunitari (supermaket Chef)
4. Docker (container engine)
5. Ha-Proxy (loadbalancer)
6. Berkshelf (gestore dipendenze cookbook)
7. ChefDK (toolkit chef)
8. Virtualbox (hypervisor)
9. Sistema operativo Centos7
10. Rubocop (syntax checker)
11. Foodcritic (cookbook checker)


### How To ###

1. Installare vagrant (https://www.vagrantup.com)
2. ```vagrant plugin install vagrant-berkshelf```
3. ```vagrant plugin install vagrant-omnibus```
4. installare ChefDK (https://downloads.chef.io/chef-dk/)
5. ```git clone $thisrepo ```
6. ```berks install```
7. ```vagrant up```



