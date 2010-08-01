$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "spec/mocks"
require 'rr'
require 'bench_press'

module CompareRRToRspec
  extend BenchPress

  name 'Compare RR mocking to Rspec'
  author 'Sandro Turriate'
  summary "Ported from the [benchmarks](http://github.com/btakita/rr/tree/master/benchmarks/) directory within the [rr](http://github.com/btakita/rr) project. Repetition really matters in this example as Rspec is much faster sub 100 repetitions."
  date '2009-08-03'

  reps 1200
  rspec_object = Object.new
  rr_object = Object.new

  measure('rspec should_receive') do
    rspec_object.should_receive(:foobar).and_return("baz")
    rspec_object.foobar
  end

  measure("rr mock") do
    RR.mock(rr_object).foobar.returns("baz")
    rr_object.foobar
    RR.reset
  end
end

puts CompareRRToRspec.bench_press
