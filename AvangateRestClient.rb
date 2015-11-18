require 'base64'
require 'cgi'
require 'openssl'

class AvangateRestClient
    @merchantCode
    @loginDate
    @hash
    @baseUrl

    def self.get(url)
        return self.execute(:get, url)
    end

    def self.post(url, payload = {})
        return self.execute(:post, url, payload)
    end

    def self.put(url, payload = {})
        return self.execute(:put, url, payload)
    end

    def self.delete(url, payload = {})
        return self.execute(:delete, url, payload)
    end

    def self.execute(method, url, payload = {})
        return RestClient::Request.execute(
            method: method,
            url: @baseUrl + url,
            payload: payload.to_json,
            headers: {
                :content_type => :json,
                :accept => :json,
                :'X-Avangate-Authentication' =>
                    'code="' + @merchantCode + '" date="' + @loginDate + '" hash="' + @hash + '"'
            }
        )
    end

    def self.setBaseUrl(baseUrl)
        @baseUrl = baseUrl
    end

    def self.setCredentials(merchantCode, apiSecretKey)
        @merchantCode = merchantCode
        @apiSecretKey = apiSecretKey
        @loginDate = Time.now.strftime("%F %T")

        raw = String(@merchantCode.length) + @merchantCode + String(@loginDate.length) + @loginDate
        @hash = hmac(raw, @apiSecretKey)
    end

    def self.hmac(data, secret)
        return OpenSSL::HMAC.hexdigest(OpenSSL::Digest.new('md5'), secret.encode("ASCII"), data.encode("ASCII"))
    end
end