module BenchPress
  class Report
    SPACING = 4

    attr_accessor :runnables, :name, :summary, :author, :date, :email

    def initialize(name = "")
      @name = name
    end

    def date
      @date ||= Date.today
    end

    def to_s
      result
      [
        cover_page,
        system_information,
        runnable_heading,
        runnable_table,
      ].join("\n\n")
    end


    def to_hash
      result
      {
        :name => name,
        :heading => heading,
        :summary => summary,
        :email => email,
        :author => author,
        :run_on => date,
        :repetitions => repetitions,
        :os => SystemInformation.os,
        :cpu => SystemInformation.cpu,
        :processor_count => SystemInformation.processor_count,
        :memory => SystemInformation.memory,
        :ruby_version => SystemInformation.ruby_version,
        :report => to_s,
        :crypted_identifier => SystemInformation.crypted_identifier,
        :runnables => runnables.map {|r| r.to_hash}
      }
    end

    protected

    def cover_page
      [
        header(name),
        announce_author,
        announce_date,
        announce_summary
      ].compact.join("\n")
    end

    def heading
      %("#{result.fastest.name}" is up to #{result.slowest.percent_slower}% faster over #{formatted_number repetitions} repetitions)
    end

    def runnable_heading
      header(heading, "-")
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

    def announce_author
      line("Author: #{author}") unless author.nil?
    end

    def announce_date
      line("Date: #{date.strftime("%B %d, %Y")}") unless date.nil?
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

    def formatted_number(number, delimiter = ',')
      number.to_s.gsub!(/(\d)(?=(\d\d\d)+(?!\d))/, "\\1#{delimiter}")
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
