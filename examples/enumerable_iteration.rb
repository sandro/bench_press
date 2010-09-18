require 'bench_press'
extend BenchPress

author 'Kieran Pilkington'
summary "Which method of enumarable interation is the fastest?"

reps 100_000

ARRAY = ('a'..'z').to_a

measure "Array#each" do
  ARRAY.each { |a| a }
end

measure "Array#each_index" do
  ARRAY.each_index { |i| ARRAY[i] }
end

measure "Array#each_with_index" do
  ARRAY.each_with_index { |a, i| a }
end

measure "Array#reverse_each" do
  ARRAY.reverse_each { |a| a }
end

measure "Array#map" do
  ARRAY.map { |a| a }
end

measure "Array#collect" do
  ARRAY.collect { |a| a }
end

measure "for" do
  for a in ARRAY
    a
  end
end

measure "while" do
  i = 0
  while i < ARRAY.size
    ARRAY[i]
    i += 1
  end
end

measure "until" do
  i = 0
  until i == ARRAY.size
    ARRAY[i]
    i += 1
  end
end

measure "Array#size.times" do
  ARRAY.size.times { |i| ARRAY[i] }
end
