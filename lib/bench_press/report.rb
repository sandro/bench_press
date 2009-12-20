module BenchPress
  class Report
    SPACING = 4

    attr_accessor :runnables, :name, :summary, :author

    def initialize(name = "")
      @name = name
    end

    def to_s
      [
        runnable_heading,
        runnable_table,
      ].join("\n\n")
    end

    def runnable_heading
      header(
        %("#{result.fastest.name}" is up to #{result.slowest.percent_slower}% faster over #{repetitions} repetitions),
        "-"
      )
    end

    def runnable_table
      result.runnables.map do |r|
        row(run_name(r.name), run_time(r.run_time), run_summary(r))
      end.join("\n")
    end

    protected

    def header(content, decorator = "=")
      [content, decorator * content.size].join("\n")
    end

    def repetitions
      Runnable.repetitions
    end

    def row(*columns)
      row = spacer
      columns.each do |column|
        row << column
      end
      row
    end

    def spacer
      ' ' * SPACING
    end

    def run_name(content)
      content.to_s.ljust(result.longest_name.size + SPACING)
    end

    def run_summary(r)
      if r == result.fastest
        "Fastest"
      else
        "#{r.percent_slower}% Slower"
      end
    end

    def run_time(secs)
      secs.to_s.ljust(result.longest_run_time.size) + " secs" + spacer
    end

    def result
      @result ||= Result.new(runnables).evaluate
    end
  end
end

__END__

HASH MERGE
===========
Author: Sandro Turriate  
Date: 12-12-09  
Summary: Fastest way to merge or append a hash to another hash  

System Information
------------------
    Operating System:    Mac OS X 10.6.2 (10C540)
    CPU:                 Intel Core 2 Duo 2.4 GHz
    Processor Count:     2
    Memory:              4 GB
    Ruby version:        1.8.7 patchlevel 174


"Implicit return" is up to 17% faster over 1000 repetitions
-----------------------------------------------------
    Implicit Return    0.00029 secs    Fastest
    Explicit           0.00035 secs    17% Slower

50% faster is 25 secs rather than 50, 50x = (50-25)
35x = (35-29) = 17%
.00035x = .00006
