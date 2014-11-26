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
for example, input json format data
- record: {"json":"message"}

stored Key/Value Storage of Consul
- {kv_prefix}/record/json: message
