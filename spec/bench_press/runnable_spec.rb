require 'spec_helper'

describe BenchPress::Runnable do

  subject do
    BenchPress::Runnable.new('fast method', lambda {})
  end

  describe "#summary" do
    context "when fastest" do
      before do
        subject.stub(:fastest? => true)
      end

      it "displays Fastest" do
        subject.summary.should == "Fastest"
      end
    end

    context "not faster" do
      before do
        subject.stub(:fastest? => false)
      end

      it "shows the percentage slower" do
        subject.percent_slower = 25
        subject.summary.should == "25% Slower"
      end
    end
  end
end
