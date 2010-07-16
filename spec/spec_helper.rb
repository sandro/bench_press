begin; require 'rubygems'; rescue LoadError; end
require 'bench_press'
require 'spec'
require 'spec/autorun'
require 'ephemeral_response'

Dir.glob("spec/support/*.rb") {|f| require f}

Spec::Runner.configure do |config|
  config.before(:suite) do
    EphemeralResponse.activate
  end

  config.after(:suite) do
    EphemeralResponse.deactivate
  end
end
