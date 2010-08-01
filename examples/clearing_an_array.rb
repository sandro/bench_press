require 'bench_press'

extend BenchPress

author 'Sandro Turriate'
date '2010-08-01'
summary "
  What's the best way to clear out an array? Could be useful if you're storing 
  messages in an array like a buffer. How should you flush the buffer when 
  you're done with it?
"

reps 10_000

ARRAY = (1..1000).to_a.freeze

measure "Array#clear" do
  a = ARRAY.dup
  a.clear
end

measure "Array#replace" do
  a = ARRAY.dup
  a.replace []
end

measure "Assign the variable to a new array" do
  a = ARRAY.dup
  a = []
end

measure "Array#-" do
  a = ARRAY.dup
  a = a - a
end

measure "Array#delete_if" do
  a = ARRAY.dup
  a.delete_if {|o| o}
end

measure "Array#drop" do
  a = ARRAY.dup
  a = a.drop(a.size)
end

measure "Array#shift(n)" do
  a = ARRAY.dup
  a.shift(a.size)
end
