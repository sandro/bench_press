require 'rubygems'
require 'bench_press'

extend BenchPress

author 'Sandro Turriate'
date '2010-07-31'
summary "String literals, interpolation, concatenation and array joins, all the many ways we create strings."


names = (first, middle, last = "First", "Middle", "Last")

measure "literal" do
  "First Middle Last"
end

measure "interpolation" do
  "#{first} #{middle} #{last}"
end

measure "append" do
  "" << first << " " << middle << " " << last
end

measure "concatenation" do
  first + " " + middle + " " + last
end

measure "array join" do
  names.join " "
end
