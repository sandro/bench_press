require 'date'
require 'time'
require 'benchmark'
require 'facter'
require 'bench_press/cli'
require 'bench_press/runnable'
require 'bench_press/result'
require 'bench_press/report'
require 'bench_press/system_information'

module BenchPress
  VERSION = '0.3.1'

  autoload :RubyBenchmark, 'bench_press/ruby_benchmark'

  class << self
    attr_reader :current

    attr_accessor :run_at_exit
    alias run_at_exit? run_at_exit

    def extended(base)
      base.instance_variable_set(:@module_name, base.to_s) if base.is_a?(Module)
      @current = base
    end
  end

  @run_at_exit = true

  def self.titleize(string)
    string.split(/[\W_]+/).map do |word|
      word.capitalize
    end.join(" ")
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

  def date(date)
    report.date = Time.parse(date)
  end

  def name(new_report_name=nil)
    if new_report_name
      report.name = new_report_name
    else
      super()
    end
  end

  def summary(summary)
    report.summary = summary
  end

  def author(author)
    report.author = author
  end

  def email(email)
    report.email = email
  end

  def reps(times)
    Runnable.repetitions = times
  end

  def measure(name, &block)
    runnables << Runnable.new(name, block)
  end

  def bench_press
    report.runnables = runnables
    report
  end

  protected

  def default_report_name
    module_name || File.basename(calling_script, ".rb")
  end

  def report_name
    BenchPress.titleize default_report_name
  end

  def calling_script
    $0
  end
end

at_exit do
  if $!.nil? && respond_to?(:bench_press) && BenchPress.run_at_exit?
    puts bench_press
  end
end
