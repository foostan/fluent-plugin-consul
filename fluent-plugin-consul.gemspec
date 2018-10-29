# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |spec|
  spec.name          = "fluent-plugin-consul"
  spec.version       = "0.0.3"
  spec.authors       = ["foostan"]
  spec.email         = ["ks@fstn.jp"]
  spec.summary       = %q{Store Fluentd event to Consul Key/Value Storage}
  spec.homepage      = "https://github.com/foostan/fluent-plugin-consul"
  spec.license       = "Apache License, Version 2.0"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "test-unit", "~> 3.2"
  spec.add_runtime_dependency "fluentd"
  spec.add_runtime_dependency 'diplomat', '~> 0.2.1'
end
