$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'benchpress'

extend Benchpress

def collection
  @collection ||= [{"_id"=>"4a9b4a823bb6dc41c4000002"}] * 10
end

compare("hash merge") do
  collection.each {|h| h.merge(:parent => 1)}
end.
to("hash merge!") do
  collection.each {|h| h.merge!(:parent => 1)}
end.
to("hash store when key is a symbol") do
  collection.each {|h| h[:parent] = 1}
end.
to("hash store when key is a string") do
  collection.each {|h| h['parent'] = 1}
end
