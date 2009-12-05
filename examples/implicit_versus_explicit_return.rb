$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

def implicit
  1
end

def explicit
  return 1
end

compare("implicit return") do
  implicit
end.
to("explicit return") do
  explicit
end

