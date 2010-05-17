module BenchPress
  require 'optparse'
  class CLI
    attr_reader :argv, :options, :filename

    def initialize(argv)
      @argv = argv
      @options = {}
      optparse.parse!(argv)
      @filename = argv.shift
    end

    def file_path
      @file_path ||= File.join(Dir.pwd, filename)
    end

    def file_exists?
      filename && File.exists?(file_path)
    end

    def optparse
      @optparse ||= OptionParser.new do |opts|
        opts.banner = "Usage: bench_press [options] file_to_benchmark.rb"

        opts.on( '-p', '--publish', 'Publish the benchmark to http://rubybenchmark.com' ) do
          options[:publish] = true
        end

        opts.on( '-v', '--version', 'Show the version of bench_press' ) do
          options[:version] = true
        end
      end
    end

    def run
      if options[:version]
        exit_with_version
      elsif file_exists?
        benchpress_file
      else
        abort "Could not proceed, please supply the filename you wish to benchmark"
      end
    end

    protected

    def benchpress_file
      if options[:publish]
        publish
      else
        IO.popen %(ruby #{file_path}) do |process|
          at_exit {Process.kill process.pid rescue Errno::ESRCH}
          puts process.read
        end
      end
    end

    def exit_with_version
      puts BenchPress::VERSION
      exit
    end

    def publish
      raise 'publish'
    end
  end
end
