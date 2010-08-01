$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

author 'Sandro Turriate'
summary "Is merging the fastest way to store values into a hash?"

reps 30_000

measure "Hash#merge" do
  {}.merge(:key => :value)
end

measure "Hash#merge!" do
  {}.merge!(:key => :value)
end

measure "Hash#[]=" do
  {}.[]=(:key, :value)
end
