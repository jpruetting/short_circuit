ENV['RAILS_ENV'] ||= 'test'

$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require File.expand_path('../dummy/config/environment', __FILE__)

require 'rails/all'
require 'rspec/rails'
require 'bundler/setup'

Bundler.require

RSpec.configure do |config|
  config.color = true
end
