$:.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end

require 'facter'
require 'benchmark'
require 'bench_press/runnable'
require 'bench_press/comparison'
require 'bench_press/system_information'

module BenchPress

  def self.extended(base)
    class << base
      attr_accessor :comparison
    end
  end

  def repitition
    @repitition ||= 1000
  end

  def reps(times)
    @repitition = times
  end

  def compare(name, &block)
    self.comparison = Comparison.new name, block
  end
  alias bm compare

  def bench_press
    puts "Running benchmarks #{repitition} times each"
    comparison.runnables.each do |runnable|
      puts runnable.name
      time = Benchmark.realtime do
        repitition.times &runnable.code_block
      end
      puts time
      puts
      # x.report(runnable.name) { n.times &runnable.code_block }
    end
  end
end

at_exit do
  bench_press if self.respond_to? :bench_press
end
