# MethodCrm

A ruby wrapper for the MethodCRM API

A complete list of service methods can be found here: [https://www.methodintegration.com/MethodAPI/service.asmx](https://www.methodintegration.com/MethodAPI/service.asmx). For this gem the V2 version of methods is assumed.

## Usage

    client = MethodClient.new('Company', 'username', 'P@SSw0rd')

    client.table_list
     => ["Account", "AccountAccountType", ... "VendorCreditLineItem", "VendorType"]

    client.table_list(:detailed)
     => [
          [  0] {
                 "TableName" => "Account",
               "SupportsAdd" => "true",
              "SupportsEdit" => "true"
          },
          [  1] {
                 "TableName" => "AccountAccountType",
               "SupportsAdd" => "false",
              "SupportsEdit" => "false"
          },
          ...
          [155] {
                 "TableName" => "VendorCreditLineItem",
               "SupportsAdd" => "true",
              "SupportsEdit" => "true"
          },
          [156] {
                 "TableName" => "VendorType",
               "SupportsAdd" => "true",
              "SupportsEdit" => "false"
          }
        ]

## Installation

Add this line to your application's Gemfile:

    gem 'method_crm'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install method_crm

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Added some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
