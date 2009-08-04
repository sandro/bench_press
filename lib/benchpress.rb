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

  def compare(name, &block)
    self.comparison = Comparison.new name, block
  end
  alias bm compare

  def benchmark
    n = 1000
    comparison.runnables.each do |runnable|
      puts runnable.name
      puts Benchmark.realtime { n.times &runnable.code_block }
      puts
      # x.report(runnable.name) { n.times &runnable.code_block }
    end
  end
end

at_exit do
  benchmark if self.respond_to? :benchmark
end
