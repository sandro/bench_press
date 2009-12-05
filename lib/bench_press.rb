$:.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end

require 'facter'
require 'benchmark'
require 'bench_press/runnable'
require 'bench_press/system_information'

module BenchPress

  def runnables
    @runnables ||= []
  end

  def reps(times)
    Runnable.repetitions = times
  end

  def measure(name, &block)
    runnables << Runnable.new(name, block)
  end

  def bench_press
    puts "Running benchmarks #{Runnable.repetitions} times each"
    runnables.each do |runnable|
      runnable.run
    end
  end
end

at_exit do
  bench_press if respond_to?(:bench_press)
end
