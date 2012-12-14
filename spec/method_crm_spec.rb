require 'spec_helper'

describe MethodCrm::Client do
  let(:client) {MethodCrm::Client.new(CONFIG[:company], CONFIG[:user], CONFIG[:password])}
  use_vcr_cassette

  describe '#table_list' do
    context "with no args" do
      it 'returns an array of table names' do
        results = client.table_list
        results.should be_an Array
        results.should include("Account", "AccountAccountType", "VendorCreditLineItem", "VendorType")
      end
    end

    context "(:detailed)" do
      it 'returns an array of table hashes' do
        results = client.table_list(:detailed)
        results.should be_an Array
        results.all? {|el| el.has_key?('TableName')}.should be
        results.all? {|el| el.has_key?('SupportsAdd')}.should be
        results.all? {|el| el.has_key?('SupportsEdit')}.should be
      end
    end
  end

  it '#field_list returns an array of field hashes' do
    client.field_list('Invoice').all? {|hash| hash.has_key?('FieldName')}.should be
  end

  it '#get_records returns a table`s records' do
    client.get_records('Account').all? {|hash| hash.has_key?('AccountNumber')}.should be
  end
end