require 'method_crm'
CONFIG = YAML.load_file(File.expand_path('../support/config.yml', __FILE__))

Dir[File.expand_path('../support/**/*.rb', __FILE__)].each{|f| require f }