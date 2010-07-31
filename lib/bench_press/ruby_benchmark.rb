module BenchPress
  require 'httparty'

  class RubyBenchmark
    include HTTParty
    base_uri 'http://rubybenchmark.com'

    def self.publish(measurable, file_path)
      report = measurable.report.to_hash
      report[:results_attributes] = report.delete(:runnables)
      report.merge! :source => File.read(file_path)
      new post("/reports", :body => {:report => report})
    end

    attr_reader :response

    def initialize(response)
      @response = response
    end

    def report_url
      response.body if successful?
    end

    protected

    def successful?
      Net::HTTPSuccess === response.response
    end
  end
end
