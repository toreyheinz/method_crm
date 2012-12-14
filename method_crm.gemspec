# -*- encoding: utf-8 -*-
Gem::Specification.new do |gem|
  gem.name          = "method_crm"
  gem.version       = '0.1.0'
  
  gem.author        = 'Torey Heinz'
  gem.email         = 'toreyheinz@gmail.com'
  gem.description   = %q{A ruby wrapper for the MethodCRM API}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/toreyheinz/method_crm'

  gem.files         = `git ls-files`.split($\)
  gem.require_path  = 'lib'

  gem.add_dependency 'rest-client', '~> 1.6'
  gem.add_dependency 'multi_xml'

  gem.add_development_dependency 'rake',    '~> 0.9'
  gem.add_development_dependency 'rspec',   '~> 2.12'
  gem.add_development_dependency 'vcr',     '~> 1.6.0'
  gem.add_development_dependency 'webmock', '~> 1.6.0'
  gem.test_files    = gem.files.grep(/^spec/)
end
