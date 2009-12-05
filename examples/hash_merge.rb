$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

reps 30_000
compare("Hash#merge") do
  {}.merge(:parent => 1)
end.
to("Hash#merge!") do
  {}.merge!(:parent => 1)
end.
to("Hash#store") do
  {}.store(:parent, 1)
end.
to("Hash#[]=") do
  {}.[]=(:parent, 1)
end
