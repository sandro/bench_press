module BenchPress
  module SystemInformation
    require 'digest/sha1'
    extend self

    def announce_cpu
      [
        announce("CPU", cpu),
        announce("Processor Count", processor_count)
      ].join("\n")
    end

    def announce_memory
      announce "Memory", memory
    end

    def announce_os
      announce "Operating System", os
    end

    def announce_ruby_version
      announce "Ruby version", ruby_version
    end

    def cpu
      if mac?
        "#{facts['sp_cpu_type']} #{facts['sp_current_processor_speed']}"
      else
        facts['processor0']
      end
    end

    def crypted_identifier
      Digest::SHA1.hexdigest(identifier)
    end

    def memory
      facts['sp_physical_memory'] || facts['memorysize']
    end

    def os
      facts['sp_os_version'] || facts['lsbdistdescription'] || facts['operatingsystem']
    end

    def processor_count
      facts['sp_number_processors'] || facts['processorcount'] || facts['physicalprocessorcount']
    end

    def ruby_version
      "#{RUBY_VERSION} patchlevel #{RUBY_PATCHLEVEL}"
    end

    def summary
      [
        announce_os,
        announce_cpu,
        announce_memory,
        announce_ruby_version
      ].join("\n")
    end

    protected

    def announce(key, value)
      key.ljust(19) << value
    end

    def facts
      @facts ||= Facter.to_hash
    end

    def identifier
      facts['sp_serial_number'] || facts['uniqueid']
    end

    def mac?
      Facter.kernel =~ /Darwin/
    end
  end
end
