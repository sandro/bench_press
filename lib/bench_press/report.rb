module BenchPress
  class Report
    attr_reader :label, :runnables, :results

    def initialize(label="", runnables)
      @label = label
      @runnables = runnables
    end

    def print
      puts label
      run
      puts results
    end

    def run
      # 100 times
      # 10_000 times
      # 100_000 times
    end

  end
end
