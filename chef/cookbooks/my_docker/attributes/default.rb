default['my_docker']['image'] = "mydockerimage"
default['my_docker']['container'] = "mydockercontainer"

default['my_docker']['ports'] = {
  "internal" => "80",
  "external" => "80"
}

default['my_docker']['files'] = '/some/local/files/:/etc/nginx/conf.d'
