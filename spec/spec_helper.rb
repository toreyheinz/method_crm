require 'bundler/setup'
require 'method_crm'

require 'vcr'

VCR.config do |c|
  c.default_cassette_options = { 
    :record => :new_episodes,
    :match_requests_on => [:method, :uri, :body]
  }
  c.stub_with :webmock
  c.cassette_library_dir = 'spec/support/cassettes'
end

CONFIG = YAML.load_file(File.expand_path('../support/config.yml', __FILE__))

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{|f| require f }

RSpec.configure do |c|
  c.extend VCR::RSpec::Macros
end