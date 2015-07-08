require 'chefspec'
require_relative 'spec_helper'

describe 'application_nodejs::default' do
  before { stub_resources }

  let(:chef_run) { ChefSpec::SoloRunner.new(step_into: ['application_nodejs']).converge(described_recipe) }

  # it 'installs package' do
  #   expect(chef_run).to install_package('nodejs')
  # end
end
