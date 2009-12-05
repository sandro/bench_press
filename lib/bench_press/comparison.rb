module BenchPress
  class Comparison
    attr_reader :runnables, :subject, :repetitions

    def initialize(name, block, repetitions)
      @subject = Runnable.new(name, repetitions, block)
      @runnables = [subject]
      @repetitions = repetitions
    end

    def report
      report = Report.new "Comparing #{subject.name} to #{runnables.size -1} other benchmarks", runnables
      report.print
    end

    def to(name, &block)
      @runnables << Runnable.new(name, repetitions, block)
      self
    end
  end
end
