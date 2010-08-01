module Measurable
  extend BenchPress

  def self.path
    File.expand_path(__FILE__)
  end

  email 'sandro@example.com'

  measure "nil" do
    nil
  end

  measure '""' do
    ""
  end
end
