module BenchPress
  class Runnable
    attr_reader :name, :code_block, :run_time

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
      puts name
      @run_time = Benchmark.realtime do
        self.class.repetitions.times &code_block
      end
      puts run_time
      puts
    end
  end
end
