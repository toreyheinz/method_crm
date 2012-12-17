require 'rest_client'
require 'multi_xml'
require 'core_ext/string'
require 'core_ext/hash'

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
        results.map { |table| table[:table_name] }
      end
    end

    def field_list(table, output = nil) 
      results = parsed_response('FieldList', {'strTable' => table})
      case output.to_s
      when 'detailed'
        results
      else
        results.map { |table| table[:field_name] }
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
      parsed_content = MultiXml.parse(content).rubyize_keys
      if parsed_content[:method_api][:response] == "Success"
        unless parsed_content[:method_api][:method_integration].nil?
          parsed_content[:method_api][:method_integration][:record]
        else
          []
        end
      else
        raise MethodCrmClientError, parsed_content[:method_api][:response]
      end
    end
  end
end
