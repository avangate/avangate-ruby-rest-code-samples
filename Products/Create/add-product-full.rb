require 'rest-client'
require 'json'
require_relative '../../AvangateRestClient.rb'

AvangateRestClient.setBaseUrl('https://api.avangate.com/rest/3.0/')
AvangateRestClient.setCredentials('APITEST', 'SECRET_KEY')


begin
	response = AvangateRestClient.post('products/', {
		:ProductCode => 'PRODUCT_TEST_AV_1',
		:ProductType => 'REGULAR',
		:ProductName => 'AV | Team',
		:ProductVersion => '',
		:GroupName => 'General',
		:ShippingClass => nil,
		:GiftOption => false,
		:ShortDescription => '',
		:LongDescription => '',
		:SystemRequirements => '',
		:ProductCategory => false,
		:Platforms => [

		],
		:ProductImages => [

		],
		:TrialUrl => '',
		:TrialDescription => '',
		:Enabled => true,
		:AdditionalFields => [

		],
		:Translations => [

		],
		:PricingConfigurations => [
			{
				:Name => 'AV | Price Configuration',
				:Code => '54BCEB100D',
				:Default => true,
				:BillingCountries => [

				],
				:PricingSchema => 'DYNAMIC',
				:PriceType => 'NET',
				:DefaultCurrency => 'USD',
				:Prices => {
					:Regular => [
						{
							:Amount => 39.99,
							:Currency => 'USD',
							:MinQuantity => '1',
							:MaxQuantity => '99999',
							:OptionCodes => [

							]
						}
					],
					:Renewal => [

					],
					:PriceOptions => [

					]
				}
			}
		],
		:Prices => [

		],
		:BundleProducts => [

		],
		:Fulfillment => 'BY_VENDOR',
		:GeneratesSubscription => true,
		:SubscriptionInformation => {
			:DeprecatedProducts => [

			],
			:BundleRenewalManagement => 'GLOBAL',
			:BillingCycle => '-1',
			:BillingCycleUnits => 'M',
			:IsOneTimeFee => true,
			:ContractPeriod => nil,
			:UsageBilling => 0,
			:GracePeriod => nil,
			:RenewalEmails => {
				:Type => 'GLOBAL',
				:Settings => {
					:ManualRenewal => {
						:Before30Days => false,
						:Before15Days => false,
						:Before7Days => true,
						:Before1Day => false,
						:OnExpirationDate => false,
						:After5Days => false,
						:After15Days => false
					},
					:AutomaticRenewal => {
						:Before30Days => false,
						:Before15Days => false,
						:Before7Days => true,
						:Before1Day => false,
						:OnExpirationDate => false,
						:After5Days => false,
						:After15Days => false
					}
				}
			}
		},
		:FulfillmentInformation => {
			:IsStartAfterFulfillment => false,
			:IsElectronicCode => false,
			:IsDownloadLink => false,
			:IsBackupMedia => false,
			:IsDownloadInsuranceService => false,
			:IsInstantDeliveryThankYouPage => true,
			:IsDisplayInPartnersCPanel => false,
			:CodeList => nil,
			:BackupMedia => nil,
			:ProductFile => nil,
			:AdditionalInformationByEmail => 'install instructions',
			:AdditionalInformationEmailTranslations => [
				{
					:Name => nil,
					:Description => 'install instructions french',
					:Language => 'FR'
				},
				{
					:Name => nil,
					:Description => 'install instructions japanese',
					:Language => 'JA'
				}
			]
		}
	})

	# display response: http status, header and contents
	puts "Response status: #{response.code}\n"

	response.headers.each { |k,v|
		puts "Header: #{k}=#{v}"
	}

	puts "\n\n"
	puts "Contents: " + response.body + "\n\n"

rescue => e
	puts e.to_json
end

# outputs
#
# Response status: 201
# Header: date=Wed, 18 Nov 2015 12:00:00 GMT
# Header: content_type=application/json
# Header: content_length=4
# Header: connection=keep-alive
# Header: etag="2b258d61"
# Header: www_authorization=X-Avangate-Session: aav6a9ikoqap9sso23ar9q43f3812iu4
# Header: allow=GET,POST
# Header: location=http://api.avangate.com/rest/3.0/products/PRODUCT_TEST_AV_2/
#
# Contents: true
#