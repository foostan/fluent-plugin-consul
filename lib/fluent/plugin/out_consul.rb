module Fluent

  class ConsulOutput < Fluent::BufferedOutput
    Fluent::Plugin.register_output('consul', self)

    config_param :consul_uri, :string, :default => 'localhost:8500'

    def configure(conf)
      super
    end

    def start
      super
    end

    def shutdown
      super
    end

    def format(tag, time, record)
      [tag, time, record].to_json + "\n"
    end

    def write(chunk)
      data = chunk.read
      print data
    end
  end
end
