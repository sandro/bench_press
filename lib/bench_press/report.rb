module BenchPress
  class Report
    SPACING = 4

    attr_accessor :runnables, :name, :summary, :author, :date

    def initialize(name = "")
      @name = name
    end

    def date
      @date ||= Date.today
    end

    def to_s
      [
        cover_page,
        system_information,
        runnable_heading,
        runnable_table,
      ].join("\n\n")
    end

    def cover_page
      [
        header(name),
        announce_author,
        announce_date,
        announce_summary
      ].compact.join("\n")
    end

    def runnable_heading
      header(
        %("#{result.fastest.name}" is up to #{result.slowest.percent_slower}% faster over #{repetitions} repetitions),
        "-"
      )
    end

    def runnable_table
      result.runnables.map do |r|
        row(run_name(r.name), run_time(r.run_time), r.summary)
      end.join("\n")
    end

    def system_information
      [
        header("System Information", '-'),
        prefix(SystemInformation.summary)
      ].join("\n")
    end

    protected

    def announce_author
      line("Author: #{author}") unless author.nil?
    end

    def announce_date
      line("Date: #{date}") unless date.nil?
    end

    def announce_summary
      line("Summary: #{summary}") unless summary.nil?
    end

    def header(content, decorator = "=")
      [content, decorator * content.size].join("\n")
    end

    def prefix(content)
      content.gsub(/^|(\\n)/, "#{$1}    ")
    end

    def line(content)
      content << "  "
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

    def run_time(secs)
      secs.to_s.ljust(result.longest_run_time.size) + " secs" + spacer
    end

    def result
      @result ||= Result.new(runnables).evaluate
    end
  end
end
