source 'https://supermarket.chef.io/'

metadata

cookbook 'application', '~> 4.1.6'
cookbook 'poise-service', '~> 1.0.1'
cookbook 'nodejs', '~> 2.4.0'

group :integration do
  cookbook 'test', path: 'test/fixtures/cookbooks/test'
end
