$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

reps 30_000

measure "Hash#merge" do
  {}.merge(:parent => 1)
end

measure "Hash#merge!" do
  {}.merge!(:parent => 1)
end

measure "Hash#store" do
  {}.store(:parent, 1)
end

measure "Hash#[]=" do
  {}.[]=(:parent, 1)
end
