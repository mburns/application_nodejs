name             "application_nodejs"
maintainer       "Michael Burns"
maintainer_email "michael@mirwin.net"
license          "Apache 2.0"
description      "Deploys and configures Node.js applications"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "2.0.1"

depends          "nodejs"
depends          "application"

supports 'ubuntu', ">= 12.04"
