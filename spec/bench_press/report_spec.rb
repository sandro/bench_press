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

  describe "#prefix" do
    it "prepends 4 spaces to the content" do
      subject.send(:prefix, "Hi There").should == "    Hi There"
    end

    it "appends 4 spaces after new-line characters" do
      subject.send(:prefix, "Hi\nThere\nSam").should == "    Hi\n    There\n    Sam"
    end
  end

  describe "#line" do
    it "appends two spaces to the end of the line" do
      subject.send(:line, "Hi There").should == "Hi There  "
    end
  end

  describe "#date" do
    it "returns today's date" do
      subject.date.should == Date.today
    end

    it "returns the custom date" do
      custom_date = Time.parse('2010-01-01')
      subject.date = custom_date
      subject.date.should == custom_date
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

      report.send(:runnable_heading).should == heading.strip
    end

    it "displays the table of results" do
      table = <<-EOS
    Implicit return    0.00029 secs    Fastest
    Explicit           0.00035 secs    17% Slower
      EOS
      report.send(:runnable_table).should == table.chop
    end
  end

  it "displays the System Information" do
    BenchPress::SystemInformation.stub(:summary => "Operating System:    Mac OS X 10.6.2 (10C540)\nCPU:                 Intel Core 2 Duo 2.4 GHz\nProcessor Count:     2\nMemory:              4 GB\nRuby version:        1.8.7 patchlevel 174")
    info = <<-EOS
System Information
------------------
    Operating System:    Mac OS X 10.6.2 (10C540)
    CPU:                 Intel Core 2 Duo 2.4 GHz
    Processor Count:     2
    Memory:              4 GB
    Ruby version:        1.8.7 patchlevel 174
    EOS
    subject.send(:system_information).should == info.chop
  end

  describe "#cover_page" do
    let(:report) do
      report = BenchPress::Report.new("Hash Merge")
      report.author = "Sandro Turriate"
      report.summary = "Various methods for appending to a hash"
      report
    end
    let (:date) { Date.new(2009,1,1) }

    before do
      Date.stub(:today => date)
    end

    it "displays the report name" do
      report.send(:cover_page).should include("Hash Merge\n==========")
    end

    it "displays the report name and author name" do
      report.send(:cover_page).should include("Hash Merge\n==========\nAuthor: Sandro Turriate  ")
    end

    it "displays the report name, author name, and date" do
      report.send(:cover_page).should include("Hash Merge\n==========\nAuthor: Sandro Turriate  \nDate: #{date.strftime("%B %d, %Y")}  ")
    end

    it "displays the report name, author name, date, and summary" do
      report.send(:cover_page).should include("Hash Merge\n==========\nAuthor: Sandro Turriate  \nDate: #{date.strftime("%B %d, %Y")}  \nSummary: Various methods for appending to a hash  ")
    end

    it "does not display the author when there is no author" do
      report.stub(:author)
      report.send(:cover_page).should == "Hash Merge\n==========\nDate: #{date.strftime("%B %d, %Y")}  \nSummary: Various methods for appending to a hash  "
    end

    it "does not display the summary when there is no summary" do
      report.stub(:summary)
      report.send(:cover_page).should == "Hash Merge\n==========\nAuthor: Sandro Turriate  \nDate: #{date.strftime("%B %d, %Y")}  "
    end

    it "only displays the date when author and summary are nil" do
      report.stub(:summary => nil, :author => nil)
      report.send(:cover_page).should == "Hash Merge\n==========\nDate: #{date.strftime("%B %d, %Y")}  "
    end
  end
end
