require 'spec_helper'

describe BenchPress::Report do
  describe "#heading" do
    it "creates a markdown h1 heading" do
      subject.send(:header, "Hi").should == "Hi\n=="
    end

    it "creates a markdown h2 heading" do
      subject.send(:header, "Hi There", '-').should == "Hi There\n--------"
    end
  end

  describe "#runnable_results" do
    let(:report) do
      r = BenchPress::Report.new
      implicit = BenchPress::Runnable.new('Implicit return', lambda { })
      explicit = BenchPress::Runnable.new('Explicit', lambda { })
      implicit.stub(:run => nil, :run_time => 0.00029)
      explicit.stub(:run => nil, :run_time => 0.00035)
      r.runnables = [implicit, explicit]
      r
    end

    it "displays a heading" do
      heading = <<-EOS
"Implicit return" is up to 17% faster over 1000 repetitions
-----------------------------------------------------------
EOS

      report.runnable_heading.should == heading.strip
    end

    it "displays the table of results" do
      table = <<-EOS
    Implicit return    0.00029 secs    Fastest
    Explicit           0.00035 secs    17% Slower
      EOS
      report.runnable_table.should == table.chop
    end
  end
end
