default['my_docker']['image'] = "mydockerimage"
default['my_docker']['containers'] =  [ "mydockercontainer" ]

default['my_docker']['containers'] = [
  {
      "name"  => "tomcat1",
      "ports" => "8080:8080",
      "files" => "/vagrant/webapps:/usr/local/tomcat/webapps"
  }
]

default['my_docker']['files'] = '/some/local/files/:/etc/nginx/conf.d'
