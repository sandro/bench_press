require 'spec_helper'

describe BenchPress do
  describe "#default_report_name" do
    it "is the name of the enclosing module" do
      mod = Module.new do
        def self.to_s
          "ModuleName"
        end
        extend BenchPress
      end
      mod.send(:default_report_name).should == "ModuleName"
    end

    it "is the name of the ruby script when the extending class has no name" do
      mod = Module.new do
        def self.to_s; nil; end
        extend BenchPress
      end
      mod.stub(:calling_script => "bench_press.rb")
      mod.send(:default_report_name).should == "bench_press"
    end
  end

  describe "#name" do
    it "sets the name of the report" do
      Measurable.module_eval do
        name "Foo versus Bar"
      end
      Measurable.report.name.should == "Foo versus Bar"
    end

    context "when no argument is provided" do
      it "returns the module name when no argument is provided" do
        Measurable.name.should == "Measurable"
      end

      it "handles nil name" do
        mod = Module.new do
          def self.name; nil; end
          extend BenchPress
        end
        mod.name.should be_nil
      end
    end
  end

  describe "#date" do
    it "sets the report date to the passed in date" do
      Measurable.date "2010/01/15"
      Measurable.report.date.should == Time.parse("2010-01-15")
    end

    it "raises a parse error for bad dates" do
      expect do
        Measurable.date 1234
      end.to raise_exception(TypeError)
    end
  end

  describe "#titleize" do
    subject do
      BenchPress
    end

    it "test" do
      subject.titleize("test").should == "Test"
    end

    it "regexp_matching" do
      subject.titleize("regexp_matching").should == "Regexp Matching"
    end

    it "regexp-matching" do
      subject.titleize("regexp-matching").should == "Regexp Matching"
    end

    it "multiple non word characters in a row" do
      subject.titleize("regexp__matching").should == "Regexp Matching"
    end

    it "handles multiple non word characters" do
      subject.titleize("one_two_three-four:five").should == "One Two Three Four Five"
    end

    it "lowercases everything but the first character" do
      subject.titleize("ONE_TWO").should == "One Two"
    end
  end
end
