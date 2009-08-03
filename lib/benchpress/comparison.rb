module Benchpress
  class Comparison
    attr_reader :runnables, :subject

    def initialize(name, block)
      @subject = Runnable.new(name, block)
      @runnables = [subject]
    end

    def report
      report = Report.new "Comparing #{subject.name} to #{runnables.size -1} other benchmarks", runnables
      report.print
    end

    def to(name, &block)
      @runnables << Runnable.new(name, block)
      self
    end
  end
end
