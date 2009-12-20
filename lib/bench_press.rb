$:.unshift(File.dirname(__FILE__))

begin; require 'rubygems'; rescue LoadError; end

require 'facter'
require 'benchmark'
require 'bench_press/runnable'
require 'bench_press/report'
require 'bench_press/system_information'
require 'active_support/inflector'

module BenchPress

  def self.extended(base)
    base.instance_variable_set(:@module_name, base.name) if base.respond_to?(:name)
  end

  def module_name
    @module_name
  end

  def runnables
    @runnables ||= []
  end

  def report
    @report ||= Report.new
  end

  def name(label = nil)
    if label.nil?
      begin
        Module.instance_method(:name).bind(self).call
      rescue TypeError; end
    else
      report.name = label
    end
  end

  def summary(summary)
    report.summary = summary
  end

  def author(author)
    report.author = author
  end

  def reps(times)
    Runnable.repetitions = times
  end

  def measure(name, &block)
    runnables << Runnable.new(name, block)
  end

  def bench_press
    report.runnables = runnables
    puts report
  end

  protected

  def default_report_name
    module_name || ActiveSupport::Inflector.titleize(File.basename(__FILE__, ".rb"))
  end
end

at_exit do
  bench_press if respond_to?(:bench_press)
end
