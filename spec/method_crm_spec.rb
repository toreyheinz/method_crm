require 'spec_helper'

describe MethodCrm::Client do
  let(:client) {MethodCrm::Client.new(CONFIG[:company], CONFIG[:user], CONFIG[:password])}

  it "gets initialized with 'company', 'user', 'password' " do
    MethodCrm::Client.new(CONFIG[:company], CONFIG[:user], CONFIG[:password]).should be
  end

  it '#table_list returns an array of table hashes' do
    client.table_list.all? {|hash| hash.has_key?('TableName')}.should be
  end

  it '#field_list returns an array of field hashes' do
    client.field_list('Invoice').all? {|hash| hash.has_key?('FieldName')}.should be
  end
end