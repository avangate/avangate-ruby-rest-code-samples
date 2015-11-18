require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
    response = AvangateRestClient.post('customers/', {
        :FirstName   => 'John',
        :LastName    => 'Ruby',
        :Email       => 'john.ruby@avangate.com',
        :Company     => 'A',
        :FiscalCode  => '123',
        :Phone       => '021-000-111',
        :Fax         => '021-000-000',
        :Address1    => 'DP10A',
        :Address2    => 'CBP, b3',
        :Zip         => '123456',
        :City        => 'Atlanta',
        :State       => 'Georgia',
        :CountryCode => 'US',
        :Language    => 'en'
    })

    # display response: http status, header and contents
    puts "Response status: #{response.code}\n"

    response.headers.each { |k,v|
        puts "Header: #{k}=#{v}"
    }

    puts "\nCustomer reference: " + response.body

rescue => e
    puts e.to_json
end


# outputs:
#
# Response status: 200
# Header: date=Wed, 18 Nov 2015 12:00:00 GMT
# Header: content_type=application/json
# Header: content_length=9
# Header: connection=keep-alive
# Header: etag="fa17cb9d"
# Header: www_authorization=X-Avangate-Session: aav6a9ikoqap9sso23ar9q43f3812iu4
# Header: allow=POST
#
# Customer reference: 601952421