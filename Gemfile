# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :

source 'https://rubygems.org'

gem 'rake'
gem 'berkshelf'

group :test do
  gem 'chefspec'
  gem 'rspec'
end

group :style do
  gem 'foodcritic', '~> 3.0'
  gem 'rubocop', '~> 0.24'
end

group :integration do
  gem 'test-kitchen'
  gem 'kitchen-vagrant'
end
