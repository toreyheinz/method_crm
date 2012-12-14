require 'spec_helper'

describe MethodCrm::Client do
  let(:client) {MethodCrm::Client.new(
    CONFIG[:company],
    CONFIG[:user],
    CONFIG[:password]
    )}
  use_vcr_cassette

  describe '#table_list' do
    it 'returns a list of table names' do
      results = client.table_list
      results.should be_an Array
      results.should include(
        "Account",
        "AccountAccountType",
        "VendorCreditLineItem",
        "VendorType"
        )
    end

    context ":detailed" do
      it 'returns a list of table details' do
        results = client.table_list(:detailed)
        results.should be_an Array
        results.all? {|el| el.has_key?('TableName')}.should be
        results.all? {|el| el.has_key?('SupportsAdd')}.should be
        results.all? {|el| el.has_key?('SupportsEdit')}.should be
      end
    end
  end

  describe '#field_list' do
    it 'returns a given table`s field names' do
      results = client.field_list('AccountAccountType')
      results.should include("AccountTypeName", "RecordID")
    end

    context ":detailed" do
      it 'returns a given table`s field details' do
        results = client.field_list('AccountAccountType', :detailed)
        results.first.keys.should include(
          "SupportsAdd",
          "SupportsEdit",
          "IsRequired",
          "FieldName",
          "MaxSize",
          "DataType"
          )
      end
    end
  end

  describe '#get_records' do
    it 'returns a given table`s records' do
      results = client.get_records('AccountAccountType')
      results.all? {|hash| hash.has_key?('AccountTypeName')}.should be
    end
  end
end