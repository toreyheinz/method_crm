require 'rest_client'
require 'multi_xml'
module MethodCrm
  class Client
    include RestClient

    def initialize(company, username, password)
      @auth = {strCompanyAccount: company, strLogin: username, strPassword:  password, strSessionID: nil}
    end

    def table_list
      parsed_response('TableList')
    end

    def field_list(table)
      parsed_response('FieldList', {'strTable' => table})
    end

    def get_records(table, fields = :all_fields)
      if fields == :all_fields
        fields = field_list(table).map { |field| field['FieldName'] }.join(',')
      end
      data = @auth.merge({strTable: table, strFields: fields, strWhereClause: nil, strGroupByClause: nil, strHaving: nil, strOrderBy: nil})
      parsed_response('Select_XML', data)
    end

  private
    def parsed_response(opperation, data={})
      result = RestClient.post("http://www.methodintegration.com/MethodAPI/service.asmx/MethodAPI#{opperation}V2", @auth.merge(data))
      content = MultiXml.parse(result)['string']['__content__']
      MultiXml.parse(content)['MethodAPI']['MethodIntegration']['Record']
    end
  end
end
