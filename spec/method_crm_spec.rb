require 'spec_helper'

describe MethodCrm::Client do
  it "gets initialized with 'company', 'user', 'password' " do
    MethodCrm::Client.new(CONFIG[:company], CONFIG[:user], CONFIG[:password]).should be
  end
end