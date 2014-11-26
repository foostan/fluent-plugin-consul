module Fluent

  class ConsulOutput < Fluent::BufferedOutput
    Fluent::Plugin.register_output('consul', self)

    config_param :consul_uri, :string, :default => 'http://localhost:8500'
    config_param :kv_prefix, :string, :default => 'fluentd'

    def initialize
      super
      require 'diplomat'
    end

    def configure(conf)
      super
      ::Diplomat.configure do |config|
        config.url = @consul_uri
      end
    end

    def format(tag, time, record)
      [tag, time, record].to_msgpack
    end

    def write(chunk)
      chunk.msgpack_each do |tag, time, record|
        consul_kvs_fmt(record).each do |kv|
          ::Diplomat.put(@kv_prefix + kv[:key].to_s, kv[:value].to_s)
        end
      end
    end

    def consul_kvs_fmt(data)
      kvs = []

      if data.is_a?(Array) || data.is_a?(Hash)
        data.each_key do |k|
          r_kvs = consul_kvs_fmt(data[k])
          r_kvs.each do |r_kv|
            kvs << { key: '/' + k + r_kv[:key], value: r_kv[:value] }
          end
        end
      else
        kvs << { key: '', value: data }
      end

      kvs
    end
  end
end
