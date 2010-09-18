require 'spec_helper'

describe BenchPress::Runnable do

  subject do
    BenchPress::Runnable.new('fast method', lambda {})
  end

  describe "#summary" do
    context "when slowest" do
      before do
        subject.stub(:slowest? => true)
      end

      it "displays Slowest" do
        subject.summary.should == "Slowest"
      end
    end

    context "when faster" do
      before do
        subject.stub(:slowest? => false)
      end

      it "shows the percentage faster" do
        subject.percent_faster = 25
        subject.summary.should == "25% Faster"
      end
    end
  end
end
