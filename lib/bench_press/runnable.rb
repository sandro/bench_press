module BenchPress
  class Runnable
    attr_reader :name, :code_block, :run_time
    attr_accessor :percent_slower

    class << self
      def repetitions
        @repetitions ||= 1000
      end

      def repetitions=(times)
        @repetitions = times
      end
    end

    def initialize(name, block)
      @name = name
      @code_block = block
    end

    def run
      @run_time = Benchmark.realtime do
        self.class.repetitions.times do |i|
          code_block.call(i)
        end
      end
    end
  end
end
