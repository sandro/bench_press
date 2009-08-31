$:.unshift(File.dirname(__FILE__))

require 'benchmark'

require 'benchpress/runnable'
require 'benchpress/comparison'

module Benchpress

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

  def benchpress
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
  benchpress if self.respond_to? :benchpress
end
