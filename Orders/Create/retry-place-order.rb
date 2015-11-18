require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
	# get an order reference
	refNo = '44009492'

	puts "Order reference: " + refNo + "\n"

	response = AvangateRestClient.post('orders/', {
		:RefNo   => refNo,
		:PaymentDetails => {
			:Type => 'CC',
			:Currency => 'EUR',
			:PaymentMethod => {
				:CardType => 'visa',
				:CardNumber => '4012888888881881',
				:CCID => '123',
				:ExpirationMonth => '01',
				:ExpirationYear => '2019',
				:HolderName => 'John Doe'
			}
		}
	})

	# display response: http status, header and contents
	puts "Response status: #{response.code}\n"

	response.headers.each { |k,v|
		puts "Header: #{k}=#{v}"
	}

	contents = JSON.parse(response.body)

	puts "\n\n"
	puts "Status: " + contents['Status'] + "\n"
	puts "Errors: " + JSON.pretty_generate(Array(contents)) + "\n\n"

rescue => e
	puts e.to_json
end
