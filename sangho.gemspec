# frozen_string_literal: true

Gem::Specification.new do |spec|
  spec.name          = 'sangho'
  spec.version       = '1.0.0'
  spec.authors       = ['Sangho']
  spec.email         = ['dev@sangho.com']
  spec.summary       = 'Sangho Ruby SDK — XAF-first payment platform for Africa'
  spec.description   = 'Official Ruby SDK for the Sangho payment API.'
  spec.homepage      = 'https://github.com/sangho/sangho-ruby'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.1'

  spec.files         = Dir['lib/**/*.rb', 'README.md', 'LICENSE']
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'faraday', '~> 2.0'
  spec.add_runtime_dependency 'json',    '~> 2.0'

  spec.add_development_dependency 'rspec',   '~> 3.12'
  spec.add_development_dependency 'rubocop', '~> 1.60'
  spec.add_development_dependency 'webmock', '~> 3.23'
end
