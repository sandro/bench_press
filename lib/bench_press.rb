require 'active_support/inflector'
require 'date'
require 'benchmark'
require 'facter'
require 'bench_press/cli'
require 'bench_press/runnable'
require 'bench_press/result'
require 'bench_press/report'
require 'bench_press/system_information'

module BenchPress
  VERSION = '0.1.3'

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
    @report ||= Report.new report_name
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
    module_name || ActiveSupport::Inflector.titleize(File.basename(calling_script, ".rb"))
  end

  def report_name
    name || default_report_name
  end

  def calling_script
    $0
  end
end

at_exit do
  bench_press if respond_to?(:bench_press)
end
