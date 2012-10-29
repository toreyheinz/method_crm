require 'spec_helper'

describe MethodCrm::Client do
  let(:client) {MethodCrm::Client.new(CONFIG[:company], CONFIG[:user], CONFIG[:password])}

  it '#table_list returns an array of table hashes' do
    client.table_list.all? {|hash| hash.has_key?('TableName')}.should be
  end

  it '#field_list returns an array of field hashes' do
    client.field_list('Invoice').all? {|hash| hash.has_key?('FieldName')}.should be
  end

  it '#get_records returns a table`s records' do
    client.get_records('Account').all? {|hash| hash.has_key?('AccountNumber')}.should be
  end
end