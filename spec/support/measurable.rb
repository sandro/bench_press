module Measurable
  extend BenchPress

  def self.path
    File.expand_path(__FILE__)
  end

  measure "nil" do
    nil
  end

  measure '""' do
    ""
  end
end
