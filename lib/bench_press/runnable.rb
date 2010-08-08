module BenchPress
  class Runnable
    attr_reader :name, :code_block, :run_time
    attr_accessor :percent_slower, :fastest

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

    def fastest?
      fastest == true
    end

    def run
      r,w = IO.pipe
      fork do
        GC.disable
        run_it
        time = Benchmark.realtime do
          run_it
        end
        w.write time
        w.close_write
        exit!
      end
      Process.waitall
      w.close_write
      @run_time = r.read.to_f
    end

    def summary
      if fastest?
        "Fastest"
      else
        "#{percent_slower}% Slower"
      end
    end

    def to_hash
      {
        :name => name,
        :run_time => run_time,
        :summary => summary,
        :fastest => fastest
      }
    end

    protected

    def run_it
      self.class.repetitions.times do |i|
        code_block.call(i)
      end
    end
  end
end
