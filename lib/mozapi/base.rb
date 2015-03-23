require 'httparty'
require 'open-uri'
require 'openssl'
require 'cgi'

module MozAPI
  class Base
    include HTTParty
    include MozAPI::Cols
    base_uri 'http://lsapi.seomoz.com/linkscape/'
    
    attr_accessor :api_id, :api_key
    
    def initialize(id, key)
      @api_id = id
      @api_key = key
    end
    
    protected 
    def calculate_signature(expires)
      signature = "#{@api_id}\n#{expires}"
      digest = OpenSSL::HMAC.digest('sha1', @api_key, signature)
          
      b64 = Digest::HMAC.base64digest(signature, @api_key, Digest::SHA1)
      CGI::escape(Base64.encode64(digest).chomp)
    end
    
    def expiration_time
      (Time.now + 5 * 60).utc.to_i
    end
  end
end