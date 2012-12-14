require 'rest_client'
require 'multi_xml'

class MethodCrmClientError < StandardError; end
module MethodCrm
  class Client

    def initialize(company, username, password)
      @auth = {strCompanyAccount: company, strLogin: username, strPassword:  password, strSessionID: nil}
    end

    def table_list(output = nil)
      results = parsed_response('TableList')
      case output.to_s
      when 'detailed'
        results
      else
        results.map { |table| table['TableName'] }
      end
    end

    def field_list(table, output = nil) 
      results = parsed_response('FieldList', {'strTable' => table})
      case output.to_s
      when 'detailed'
        results
      else
        results.map { |table| table['FieldName'] }
      end
    end

    def get_records(table, options={})
      options[:fields] ||= field_list(table).join(',')
      options = {:where => nil}.merge(options)
      data = @auth.merge({strTable: table, strFields: options[:fields], strWhereClause: options[:where], strGroupByClause: nil, strHaving: nil, strOrderBy: nil})
      parsed_response('Select_XML', data)
    end

    def get_record(table, options={})
      record = get_records(table, options)
      raise MethodCrmClientError, 'Query returned more than one record' unless record.is_a?(Hash)
      record
    end
  private
    def parsed_response(opperation, data={})
      result = RestClient.post("http://www.methodintegration.com/MethodAPI/service.asmx/MethodAPI#{opperation}V2", @auth.merge(data))
      xml    = MultiXml.parse(result)
      content = xml['string']['__content__'] || xml['string']
      MultiXml.parse(content)['MethodAPI']['MethodIntegration']['Record']
    end
  end
end
