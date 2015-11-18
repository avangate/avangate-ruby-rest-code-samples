require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
    # get a product code
    responseProduct = AvangateRestClient.get('products/?Limit=1&Enabled=1&Types[]=REGULAR')
    productCode = JSON.parse(responseProduct.body)[0]['ProductCode']
	# productCode = 'THIRD'

    response = AvangateRestClient.post('orders/', {
        :Items   => [
            {
                :Code => productCode,
                :Quantity => 1
            }
        ],
        :BillingDetails => {
            :FirstName => 'John',
            :LastName => 'Ruby',
            :Email => 'john.ruby@avangate.com',
            :CountryCode => 'US'
        },
        :PaymentDetails => {
            :Type => 'CC',
            :Currency => 'EUR',
            :PaymentMethod => {
                :CardType => 'visa',
                :CardNumber => '4111111111111111',
                :CCID => '123',
                :ExpirationMonth => '10',
                :ExpirationYear => '2020',
                :HolderName => 'John Ruby'
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
    puts "Order reference: " + contents['RefNo'] + "\n"
    puts "Status: " + contents['Status'] + "\n"
    puts "Errors: " + JSON.pretty_generate(Array(contents['Errors'])) + "\n\n"
    puts "Complete order information: \n" + JSON.pretty_generate(contents)

rescue => e
    puts e.to_json
end


# outputs:
#
# Response status: 201
# Header: date=Wed, 18 Nov 2015 12:00:00 GMT
# Header: content_type=application/json
# Header: content_length=2218
# Header: connection=keep-alive
# Header: etag="b78196cf"
# Header: www_authorization=X-Avangate-Session: aav6a9ikoqap9sso23ar9q43f3812iu4
# Header: allow=GET,POST
# Header: location=http://api.avangate.com/rest/3.0/orders/43687706/
#
#
# Order reference: 43734216
# Status: PENDING
# Errors: {
#     "CARD_PAYMENT_ERROR": "Couldn't complete the payment validation process"
# }
#
#
# Complete order information:
# {
#     "RefNo": "43687706",
#     "OrderNo": 0,
#     "ExternalReference": null,
#     "ShopperRefNo": null,
#     "Status": "PENDING",
#     "ApproveStatus": "WAITING",
#     "VendorApproveStatus": "OK",
#     "Language": "en",
#     "OrderDate": "2015-11-18 01:57:14",
#     "FinishDate": null,
#     "Source": null,
#     "AffiliateSource": null,
#     "AffiliateId": null,
#     "AffiliateName": null,
#     "AffiliateUrl": null,
#     "RecurringEnabled": false,
#     "HasShipping": false,
#     "BillingDetails": {
#         "FiscalCode": null,
#         "Phone": null,
#         "FirstName": "John",
#         "LastName": "Ruby",
#         "Company": null,
#         "Email": "john.ruby@avangate.com",
#         "Address1": "",
#         "Address2": "",
#         "City": null,
#         "Zip": null,
#         "CountryCode": "us",
#         "State": null
#     },
#     "DeliveryDetails": {
#         "Phone": null,
#         "FirstName": "John",
#         "LastName": "Ruby",
#         "Company": null,
#         "Email": "john.ruby@avangate.com",
#         "Address1": "",
#         "Address2": "",
#         "City": null,
#         "Zip": null,
#         "CountryCode": "us",
#         "State": null
#     },
#     "PaymentDetails": {
#         "Type": "CC",
#         "Currency": "eur",
#         "PaymentMethod": {
#             "FirstDigits": "4111",
#             "LastDigits": "1111",
#             "CardType": "Visa",
#             "RecurringEnabled": false
#         },
#         "CustomerIP": "188.27.171.132"
#     },
#     "CustomerDetails": null,
#     "Origin": "API",
#     "AvangateCommission": 2.34,
#     "OrderFlow": "REGULAR",
#     "GiftDetails": null,
#     "PODetails": null,
#     "ExtraInformation": {
#         "PaymentLink": "https://secure.avangate.com/order/finish.php?id=2Xrl83GSoaKNunHrpL%2B6ZXKAqoLecbFt"
#     },
#     "PartnerCode": null,
#     "PartnerMargin": null,
#     "PartnerMarginPercent": null,
#     "ExtraMargin": null,
#     "ExtraMarginPercent": null,
#     "ExtraDiscount": null,
#     "ExtraDiscountPercent": null,
#     "LocalTime": null,
#     "TestOrder": false,
#     "Errors": [
#
#     ],
#     "Items": [
#         {
#             "ProductDetails": {
#                 "Name": "Simple Third Product",
#                 "ExtraInfo": null,
#                 "RenewalStatus": false,
#                 "Subscriptions": null
#             },
#             "PriceOptions": [
#
#             ],
#             "Price": {
#                 "UnitNetPrice": 11,
#                 "UnitGrossPrice": 11,
#                 "UnitVAT": 0,
#                 "UnitDiscount": 0,
#                 "UnitNetDiscountedPrice": 11,
#                 "UnitGrossDiscountedPrice": 11,
#                 "UnitAffiliateCommission": 0,
#                 "Currency": "eur",
#                 "NetPrice": 11,
#                 "GrossPrice": 11,
#                 "NetDiscountedPrice": 11,
#                 "GrossDiscountedPrice": 11,
#                 "Discount": 0,
#                 "VAT": 0,
#                 "AffiliateCommission": 0
#             },
#             "Code": "THIRD",
#             "Quantity": 1,
#             "SKU": null,
#             "CrossSell": null,
#             "Trial": null,
#             "AdditionalFields": null,
#             "Promotion": null
#         }
#     ],
#     "Promotions": [
#
#     ],
#     "AdditionalFields": null,
#     "Currency": "eur",
#     "NetPrice": 11,
#     "GrossPrice": 11,
#     "NetDiscountedPrice": 11,
#     "GrossDiscountedPrice": 11,
#     "Discount": 0,
#     "VAT": 0,
#     "AffiliateCommission": 0
# }
#
