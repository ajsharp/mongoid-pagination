require 'rubygems'
require 'bundler'
Bundler.setup :default, :test
Bundler.require :default, :test

$:.push(File.expand_path(File.dirname(__FILE__)))
require './lib/mongoid-pagination'

Mongoid.load!('./spec/config/mongoid.yml', 'test')

RSpec.configure do |config|
  config.before(:each) do
    Mongoid.purge!
  end
end
