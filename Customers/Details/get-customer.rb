require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
  response = AvangateRestClient.get('customers/601952421/')

  # display response: http status, header and contents
  puts "Response status: #{response.code}\n"

  response.headers.each { |k,v|
    puts "Header: #{k}=#{v}"
  }

  puts JSON.pretty_generate(JSON.parse(response.body))

rescue => e
  puts e.to_json
end


# outputs:
#
# Response status: 200
# Header: date=Wed, 18 Nov 2015 12:00:00 GMT
# Header: content_type=application/json
# Header: content_length=391
# Header: connection=keep-alive
# Header: etag="295a9126"
# Header: www_authorization=X-Avangate-Session: aav6a9ikoqap9sso23ar9q43f3812iu4
# Header: allow=HEAD,GET,PUT
# {
#     "AvangateCustomerReference": "601952421",
#     "ExternalCustomerReference": null,
#     "FirstName": "John",
#     "LastName": "Ruby",
#     "Company": "A",
#     "FiscalCode": "123",
#     "Address1": "DP10A",
#     "Address2": "CBP, b3",
#     "City": "Atlanta",
#     "State": "Georgia",
#     "Zip": "123456",
#     "CountryCode": "us",
#     "Phone": "021-000-111",
#     "Fax": "021-000-000",
#     "Email": "john.ruby@avangate.com",
#     "ExistingCards": [
#
#     ],
#     "Enabled": false,
#     "Trial": false,
#     "Language": "en"
# }
#
