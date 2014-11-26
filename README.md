# Consul output plugin for [Fluentd](http://www.fluentd.org)

fluent-plugin-consul store Fluentd event to Consul Key/Value Storage

## Installing

```
gem install fluent-plugin-consul
```

## Configuration
example configuration

```
<store>
  type consul
  consul_uri http://localhost:8500 # default
  kv_prefix fluentd # default
</store>
```

## Storing to Consul
input a json format data and store to Consul

for example, input record is
```json
{
    "server": {
        "ip":"10.0.0.10",
        "netmask":"255.0.0.0"
    },
    "client": {
        "ip":"192.168.33.10",
        "netmask":"255.255.255.0"
    }
}
```

stored Key/Value Storage of Consul
- {kv_prefix}/server/ip: 10.0.0.10
- {kv_prefix}/server/netmask: 255.0.0.0
- {kv_prefix}/client/ip: 192.168.33.10
- {kv_prefix}/client/netmask: 255.255.255.0
