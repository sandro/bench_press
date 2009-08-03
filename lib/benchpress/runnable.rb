module Benchpress
  class Runnable
    attr_reader :name, :code_block

    def initialize(name, block)
      @name = name
      @code_block = block
    end
  end
end
