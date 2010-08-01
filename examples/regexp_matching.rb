$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

extend BenchPress

author 'Sandro Turriate'
summary %(
  Ported from James Golick's [gist](https://gist.github.com/335639/81d140ebc1577a917cf70cf5d1ed73c777a1b3bd) wherein we compare the `=~` operator to the `String#match` method.
)

reps 1000

measure "String#match" do
  "abcdefg".match /a/
end

measure "=~" do
  "abcdefg" =~ /a/
end
