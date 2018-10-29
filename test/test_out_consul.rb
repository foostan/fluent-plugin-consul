require 'fluent/test'
require 'fluent/plugin/out_consul'

class TestConsulOutput < Test::Unit::TestCase
  def setup
    Fluent::Test.setup
  end

  CONFIG = '
    consul_uri localhost:8500
    kv_prefix fluentd
  '

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
    assert_equal 'fluentd', d.instance.kv_prefix
  end

  def test_consul_kvs_fmt
    d = create_driver
    data = {
        'key1' => {
            'sub_key1-1' => 'value1',
            'sub_key1-2' => 'value2',
        },
        'key2' => {
            'sub_key2-1' => 'value3',
            'sub_key2-2' => 'value4',
        },
        'key3' => 'value5'
    }

    consul_kvs = [
        Hash(:key => '/key1/sub_key1-1', :value => 'value1'),
        Hash(:key => '/key1/sub_key1-2', :value => 'value2'),
        Hash(:key => '/key2/sub_key2-1', :value => 'value3'),
        Hash(:key => '/key2/sub_key2-2', :value => 'value4'),
        Hash(:key => '/key3', :value => 'value5'),
    ]

    assert_equal consul_kvs, d.instance.consul_kvs_fmt(data)
  end
end