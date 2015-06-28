name 'application_nodejs'
maintainer 'Conrad Kramer'
maintainer_email 'conrad@kramerapps.com'
license 'Apache 2.0'
description 'Deploys and configures Node.js applications'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '2.0.2'
source_url 'https://github.com/mburns/application_nodejs' if respond_to?(:source_url)
issues_url 'https://github.com/mburns/application_nodejs/issues' if respond_to?(:issues_url)

depends 'nodejs'
depends 'application'

supports 'ubuntu', '>= 12.04'
