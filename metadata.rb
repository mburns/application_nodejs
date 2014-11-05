name             "application_nodejs"
maintainer       "Conrad Kramer"
maintainer_email "conrad@kramerapps.com"
license          "Apache 2.0"
description      "Deploys and configures Node.js applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.1"

depends 'nodejs'
depends 'application'
depends 'runit'
depends 'apache2'
depends 'nginx'
depends 'passenger_apache2'
supports 'ubuntu', ">= 12.04"
supports 'debian'
