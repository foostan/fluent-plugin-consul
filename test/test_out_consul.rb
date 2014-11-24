require 'fluent/test'
require 'fluent/plugin/out_consul'

class TestConsulOutput < MiniTest::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = %[
    consul_uri localhost:8500
  ]

  def create_driver(conf = CONFIG)
    Fluent::Test::BufferedOutputTestDriver.new(Fluent::ConsulOutput) do
      def write(chunk)
        chunk.read
      end
    end.configure(conf)
  end

  def test_configure
    d = create_driver
    assert_equal 'localhost:8500', d.instance.consul_uri
  end
end