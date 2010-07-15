module BenchPress
  require 'httparty'
  class RubyBenchmark
    include HTTParty
    base_uri 'http://rubybenchmark.com'

    def self.publish(pressed, file_path)
      report = pressed.report.to_hash
      report[:results_attributes] = report.delete(:runnables)
      report.merge! :source => File.read(file_path)
      post("/reports", :query => {:report => report})
    end
  end
end
