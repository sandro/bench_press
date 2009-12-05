module BenchPress
  class Runnable
    attr_reader :name, :code_block, :run_time, :repetitions

    def initialize(name, repetitions, block)
      @name = name
      @code_block = block
      @repetitions = repetitions
    end

    def run
      puts name
      @run_time = Benchmark.realtime do
        repetitions.times &code_block
      end
      puts run_time
      puts
    end
  end
end
