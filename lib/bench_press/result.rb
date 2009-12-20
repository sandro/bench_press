module BenchPress
  class Result
    attr_reader :runnables

    def initialize(runnables)
      @runnables = runnables
    end

    def evaluate
      sort
      grade
      self
    end

    def sort
      runnables.each {|r| r.run}
      @runnables = runnables.sort_by {|r| r.run_time}
    end

    def fastest
      runnables.first
    end

    def slowest
      runnables.last
    end

    def longest_name
      runnables.sort_by {|r| r.name.size}.last.name
    end

    def longest_run_time
      runnables.sort_by {|r| r.run_time.to_s.size}.last.run_time.to_s
    end

    def grade
      runnables.each do |r|
        r.percent_slower = percentage_slower(r.run_time)
      end
    end

    protected

    def percentage_slower(time)
      (((time - fastest.run_time) / time) * 100).to_i
    end
  end
end
