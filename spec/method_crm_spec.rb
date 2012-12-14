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
        results.first.keys.should include(
            'TableName',
            'SupportsAdd',
            'SupportsEdit'
          )
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
      results.map {|record| record['AccountTypeName'] }.should include(
          "AccountsPayable",
          "AccountsReceivable",
          "Bank",
          "CostOfGoodsSold",
          "CreditCard",
          "Equity",
          "Expense",
          "FixedAsset",
          "Income",
          "LongTermLiability", 
          "NonPosting", 
          "OtherAsset", 
          "OtherCurrentAsset", 
          "OtherCurrentLiability", 
          "OtherExpense", 
          "OtherIncome", 
          "Suspense"
        )
    end
  end
end