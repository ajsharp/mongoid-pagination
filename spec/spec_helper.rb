require 'rubygems'
require 'bundler'

Bundler.setup :default, :test
Bundler.require :default, :test

require './lib/mongoid-pagination'

Mongoid.database = Mongo::Connection.new.db('mongoid-pagination_test')

RSpec.configure do |c|
  c.before(:each) do
    Mongoid.database.collections.each { |c| c.drop unless c.name =~ /system\.indexes$/}
  end
end