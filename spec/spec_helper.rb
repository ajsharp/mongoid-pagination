require 'rubygems'
require 'bundler'

Bundler.setup :default, :test
Bundler.require :default, :test

$:.push(File.expand_path(File.dirname(__FILE__)))
require './lib/mongoid-pagination'

Mongoid.load!("./mongoid.yml", :test)

RSpec.configure do |c|
  c.before(:each) do
    Mongoid.default_session.collections.each { |c| c.drop unless c.name =~ /system\.indexes$/}
  end
end
