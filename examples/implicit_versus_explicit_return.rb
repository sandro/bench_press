$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

def implicit
  1
end

def explicit
  return 1
end

measure("implicit return") do
  implicit
end
measure("explicit return") do
  explicit
end

