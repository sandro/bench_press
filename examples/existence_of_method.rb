$:.unshift(File.dirname(__FILE__) + "/../lib")
require 'bench_press'

module ExistenceOfMethod
  extend BenchPress

  class A
    def c
    end
  end

  a = A.new

  compare('method_defined?') do
    A.method_defined? :c
  end.to('respond_to?') do
    a.respond_to? :c
  end.to('instance_methods include') do
    A.instance_methods.include? :c
  end.to('instance_methods(false) include') do
    A.instance_methods(false).include? :c
  end
end

ExistenceOfMethod.bench_press
