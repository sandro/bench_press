require 'spec_helper'

describe BenchPress::RubyBenchmark do
  let(:measurable) { Measurable.dup }

  before do
    BenchPress::RubyBenchmark.base_uri "http://localhost:3000"
  end

  describe "#to_s" do
    subject do
      BenchPress::RubyBenchmark.publish measurable, measurable.path
    end

    context "when report is successfully created" do
      before do
        measurable.bench_press
        Benchmark.stub(:realtime => 1)
      end

      it "returns the response body" do
        subject.to_s.should =~ %r(http://localhost:3000/reports/\d+)
      end
    end

    context "when creating the report is unsuccessful" do
      before do
        invalid_hash = {:runnables => {}}
        measurable.report.stub(:to_hash => invalid_hash)
      end

      it "contains error messages" do
        subject.to_s.should include("can't be blank")
      end
    end
  end
end
