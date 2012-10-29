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

  private
    def parsed_response(opperation, data={})
      result = RestClient.post("http://www.methodintegration.com/MethodAPI/service.asmx/MethodAPI#{opperation}V2", @auth.merge(data))
      content = MultiXml.parse(result)['string']['__content__']
      MultiXml.parse(content)['MethodAPI']['MethodIntegration']['Record']
    end
  end
end
