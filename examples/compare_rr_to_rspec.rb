$:.unshift(File.dirname(__FILE__) + "/../lib")
require "rubygems"
require "spec/mocks"
require 'rr'
require 'bench_press'

module CompareRRToRspec
  extend BenchPress

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
