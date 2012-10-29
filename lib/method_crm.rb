require 'rest_client'
require 'multi_xml'
module MethodCrm
  class Client
    include RestClient

    def initialize(company, username, password)
      @auth = {strCompanyAccount: company, strLogin: username, strPassword:  password, strSessionID: nil}
    end

    def table_list
    result = RestClient.post('http://www.methodintegration.com/MethodAPI/service.asmx/MethodAPITableListV2', @auth)
    content = MultiXml.parse(result)['string']['__content__']
    MultiXml.parse(content)['MethodAPI']['MethodIntegration']['Record']
    end

    def field_list(table)
      result = RestClient.post('http://www.methodintegration.com/MethodAPI/service.asmx/MethodAPIFieldListV2', @auth.merge('strTable' => table))
      content = MultiXml.parse(result)['string']['__content__']
      MultiXml.parse(content)['MethodAPI']['MethodIntegration']['Record']
    end
  end
end
