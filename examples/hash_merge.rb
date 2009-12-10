$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

reps 30_000

measure "Hash#merge" do
  {}.merge(:key => :value)
end

measure "Hash#merge!" do
  {}.merge!(:key => :value)
end

measure "Hash#store" do
  {}.store(:key, :value)
end

measure "Hash#[]=" do
  {}.[]=(:key, :value)
end
