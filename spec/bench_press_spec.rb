require 'spec_helper'

module TestModule
  extend BenchPress
end

describe BenchPress do
  describe "#default_report_name" do
    it "is the name of the enclosing module" do
      mod = Module.new do
        def self.name
          "ModuleName"
        end
        extend BenchPress
      end
      mod.send(:default_report_name).should == "ModuleName"
    end

    it "is the name of the ruby script when the extending class has no name" do
      mod = Module.new do
        class << self
          undef name
        end
        extend BenchPress
      end
      mod.stub(:calling_script => "bench_press.rb")
      mod.send(:default_report_name).should == "Bench Press"
    end
  end

  describe "#name" do
    it "sets the name of the report" do
      TestModule.module_eval do
        name "Foo versus Bar"
      end
      TestModule.report.name.should == "Foo versus Bar"
    end

    context "when no argument is provided" do
      it "returns the module name when no argument is provided" do
        TestModule.name.should == "TestModule"
      end

      it "rescues TypeError and returns nil" do
        Module.stub(:instance_method).and_raise(TypeError)
        TestModule.name.should be_nil
      end
    end
  end
end
