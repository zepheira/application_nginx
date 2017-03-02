name             "application_z_nginx"
maintainer       "Opscode, Inc."
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Deploys and configures Nginx as an application server"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "3.0.4"

depends "application", "~> 4.0"
depends "chef_nginx"
