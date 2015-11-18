require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
    # get a product code
    responseProduct = AvangateRestClient.get('products/?Limit=1&Enabled=1&Types[]=REGULAR')
    productCode = JSON.parse(responseProduct.body)[0]['ProductCode']
	# productCode = 'SECOND'

    response = AvangateRestClient.post('orders/', {
        :Items   => [
            {
                :Code => productCode,
                :Quantity => 1
            }
        ],
        :BillingDetails => {
            :FirstName => 'John',
            :LastName => 'Doe',
            :Email => 'john.doe@avangate.com',
            :CountryCode => 'US'
        },
        :PaymentDetails => {
            :Type => 'TEST',
            :Currency => 'EUR',
            :PaymentMethod => {
                :CardType => 'mastercard',
                :CardNumber => '5555555555554444',
                :CCID => '123',
                :ExpirationMonth => '10',
                :ExpirationYear => '2020',
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
# Header: content_length=2890
# Header: connection=keep-alive
# Header: etag="2c84e92f"
# Header: www_authorization=X-Avangate-Session: aav6a9ikoqap9sso23ar9q43f3812iu4
# Header: allow=GET,POST
# Header: location=http://api.avangate.com/rest/3.0/orders/44009492/
#
#
# Order reference: 44009492
# Status: AUTHRECEIVED
# Errors: [
#
# ]
#
# Complete order information:
# {
#     "RefNo": "44009492",
#     "OrderNo": 0,
#     "ExternalReference": null,
#     "ShopperRefNo": null,
#     "Status": "AUTHRECEIVED",
#     "ApproveStatus": "WAITING",
#     "VendorApproveStatus": "OK",
#     "Language": "en",
#     "OrderDate": "2015-11-18 02:28:12",
#     "FinishDate": null,
#     "Source": null,
#     "AffiliateSource": null,
#     "AffiliateId": null,
#     "AffiliateName": null,
#     "AffiliateUrl": null,
#     "RecurringEnabled": false,
#     "HasShipping": true,
#     "BillingDetails": {
#         "FiscalCode": null,
#         "Phone": null,
#         "FirstName": "John",
#         "LastName": "Doe",
#         "Company": null,
#         "Email": "john.doe@avangate.com",
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
#         "LastName": "Doe",
#         "Company": null,
#         "Email": "john.doe@avangate.com",
#         "Address1": "",
#         "Address2": "",
#         "City": null,
#         "Zip": null,
#         "CountryCode": "us",
#         "State": null
#     },
#     "PaymentDetails": {
#         "Type": "TEST",
#         "Currency": "eur",
#         "PaymentMethod": {
#             "FirstDigits": "55555",
#             "LastDigits": "4444",
#             "CardType": "mastercard",
#             "RecurringEnabled": false
#         },
#         "CustomerIP": "188.27.171.132"
#     },
#     "CustomerDetails": null,
#     "Origin": "API",
#     "AvangateCommission": 9.19,
#     "OrderFlow": "REGULAR",
#     "GiftDetails": null,
#     "PODetails": null,
#     "ExtraInformation": {
#         "PaymentLink": "https://store.avancart.com/order/finish.php?id=2Xrl83GSoaKNsoHuftXSZXKAw4LccbFt"
#     },
#     "PartnerCode": null,
#     "PartnerMargin": null,
#     "PartnerMarginPercent": null,
#     "ExtraMargin": null,
#     "ExtraMarginPercent": null,
#     "ExtraDiscount": null,
#     "ExtraDiscountPercent": null,
#     "LocalTime": null,
#     "TestOrder": true,
#     "Errors": null,
#     "Items": [
#         {
#             "ProductDetails": {
#                 "Name": "Demo Subscription",
#                 "ExtraInfo": null,
#                 "RenewalStatus": false,
#                 "Subscriptions": null
#             },
#             "PriceOptions": [
#                 {
#                     "Code": "SUPPORT",
#                     "Required": false,
#                     "Options": [
#                         "emailsupport"
#                     ]
#                 },
#                 {
#                     "Code": "USERS",
#                     "Required": false,
#                     "Options": [
#                         "oneuser1"
#                     ]
#                 }
#             ],
#             "Price": {
#                 "UnitNetPrice": 92.82,
#                 "UnitGrossPrice": 92.82,
#                 "UnitVAT": 0,
#                 "UnitDiscount": 0,
#                 "UnitNetDiscountedPrice": 92.82,
#                 "UnitGrossDiscountedPrice": 92.82,
#                 "UnitAffiliateCommission": 0,
#                 "Currency": "eur",
#                 "NetPrice": 92.82,
#                 "GrossPrice": 92.82,
#                 "NetDiscountedPrice": 92.82,
#                 "GrossDiscountedPrice": 92.82,
#                 "Discount": 0,
#                 "VAT": 0,
#                 "AffiliateCommission": 0
#             },
#             "Code": "3123546765csacw23e",
#             "Quantity": 1,
#             "SKU": null,
#             "CrossSell": null,
#             "Trial": null,
#             "AdditionalFields": null,
#             "Promotion": null
#         },
#         {
#             "ProductDetails": {
#                 "Name": "Shipping fees",
#                 "ExtraInfo": null,
#                 "RenewalStatus": false,
#                 "Subscriptions": null
#             },
#             "PriceOptions": [
#
#             ],
#             "Price": {
#                 "UnitNetPrice": 46.88,
#                 "UnitGrossPrice": 46.88,
#                 "UnitVAT": 0,
#                 "UnitDiscount": 0,
#                 "UnitNetDiscountedPrice": 46.88,
#                 "UnitGrossDiscountedPrice": 46.88,
#                 "UnitAffiliateCommission": 0,
#                 "Currency": "eur",
#                 "NetPrice": 46.88,
#                 "GrossPrice": 46.88,
#                 "NetDiscountedPrice": 46.88,
#                 "GrossDiscountedPrice": 46.88,
#                 "Discount": 0,
#                 "VAT": 0,
#                 "AffiliateCommission": 0
#             },
#             "Code": "SHIPPING_GENERIC_PRODUCT",
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
#     "NetPrice": 139.7,
#     "GrossPrice": 139.7,
#     "NetDiscountedPrice": 139.7,
#     "GrossDiscountedPrice": 139.7,
#     "Discount": 0,
#     "VAT": 0,
#     "AffiliateCommission": 0
# }
#
