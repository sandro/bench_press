require 'spec_helper'

describe BenchPress::SystemInformation do
  before do
    BenchPress::SystemInformation.stub(:ruby_version => "ruby 1.8.7 (2009-12-24 patchlevel 248) [i686-darwin10.2.0], MBARI 0x6770, Ruby Enterprise Edition 2010.01")
  end

  context "for Mac OS X" do
    before do
      @facts = {
        'sp_physical_memory' => '4 GB',
        'sp_os_version' => 'Mac OS X 10.6.2 (10C540)',
        'sp_cpu_type' => 'Intel Core 2 Duo',
        'sp_current_processor_speed' => '2.4 GHz',
        'sp_number_processors' => '2',
        'sp_serial_number' => '123ABC'
      }
      BenchPress::SystemInformation.stub(:mac? => true)
      BenchPress::SystemInformation.stub(:facts => @facts)
    end

    it "summarizes system information" do
      summary = <<-EOS
Operating System:    Mac OS X 10.6.2 (10C540)
CPU:                 Intel Core 2 Duo 2.4 GHz
Processor Count:     2
Memory:              4 GB
ruby 1.8.7 (2009-12-24 patchlevel 248) [i686-darwin10.2.0], MBARI 0x6770, Ruby Enterprise Edition 2010.01
      EOS
      BenchPress::SystemInformation.summary.should == summary.strip
    end

    it "encrypts the serial number" do
      BenchPress::SystemInformation.crypted_identifier.should == Digest::SHA1.hexdigest("123ABC")
    end
  end

  context "for Linux" do
    before do
      @facts = {
        'memorysize' => '254.75 MB',
        'lsbdistdescription' => 'Ubuntu 8.10',
        'processor0' => 'Dual Core AMD Opteron(tm) Processor 270',
        'processorcount' => '4',
        'uniqueid' => '123ABC'
      }
      BenchPress::SystemInformation.stub(:mac? => false)
      BenchPress::SystemInformation.stub(:facts => @facts)
    end

    it "summarizes system information" do
      summary = <<-EOS
Operating System:    Ubuntu 8.10
CPU:                 Dual Core AMD Opteron(tm) Processor 270
Processor Count:     4
Memory:              254.75 MB
ruby 1.8.7 (2009-12-24 patchlevel 248) [i686-darwin10.2.0], MBARI 0x6770, Ruby Enterprise Edition 2010.01
      EOS
      BenchPress::SystemInformation.summary.should == summary.strip
    end

    it "encrypts the unique id" do
      BenchPress::SystemInformation.crypted_identifier.should == Digest::SHA1.hexdigest("123ABC")
    end
  end
end
