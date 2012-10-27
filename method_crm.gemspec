# -*- encoding: utf-8 -*-
require File.expand_path('../lib/method_crm/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name          = "method_crm"
  gem.version       = '0.0.1'
  
  gem.author        = 'Torey Heinz'
  gem.email         = 'toreyheinz@gmail.com'
  gem.description   = %q{A ruby wrapper for the MethodCRM API}
  gem.summary       = gem.description
  gem.homepage      = 'https://github.com/toreyheinz/method_crm'

  gem.files         = `git ls-files`.split($\)
  # gem.test_files    = gem.files.grep(/^spec/)
  gem.require_path  = 'lib'
end
