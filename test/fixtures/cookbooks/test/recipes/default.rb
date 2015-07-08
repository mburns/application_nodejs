#
# Cookbook Name:: test
# Recipe:: default
#
# License:: Apache License, Version 2.0
#

application 'hello-world' do
  path '/srv/node-hello-world'
  owner 'www-data'
  group 'www-data'
  packages ['git']

  repository 'git://github.com/visionmedia/express.git'

  nodejs do
    entry_point 'examples/hello-world'
  end
end
