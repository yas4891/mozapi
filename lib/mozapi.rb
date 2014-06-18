require 'httparty'
require 'open-uri'
require 'openssl'
require 'cgi'

class Hash
  # very naive implementation of to_query
  def to_query
    map { |key, value| "#{key}=#{value}" }.join('&')
  end
end


class MozAPI
  include HTTParty
  base_uri 'http://lsapi.seomoz.com/linkscape'
  
  # there is a global limit on the Mozscape API that only lets you 
  # retrieve 100,000 links for any URL
  GLOBAL_LIMIT = 100000
  
  LIMIT = 100
  # URL + root_domain + page_authority + domain_authority
  DEFAULT_SOURCE_COLS = 4 + 16 + 34359738368 + 68719476736
  # URL + root_domain
  DEFAULT_TARGET_COLS = 4 + 16
  # anchor_text
  DEFAULT_LINK_COLS   = 4
  
  
  def initialize
    @api_id = ENV['MOZ_API_ID']
    @api_key = ENV['MOZ_API_KEY']
  end
  
  def links(target_url, options)
    sleep(10) # do this to honor the API rate limit
    # add 5 minutes
    expires = (Time.now + 5 * 60).utc.to_i
    
    options = {
      Sort: 'page_authority',
      Filter: 'follow+external',
      SourceCols: DEFAULT_SOURCE_COLS,
      TargetCols: DEFAULT_TARGET_COLS,
      LinkCols: DEFAULT_LINK_COLS,
      AccessID: @api_id,
      Expires: expires,
      Signature: calculate_signature(expires),
      Limit: LIMIT,
      Offset: 0
    }.merge(options)
    
    #puts "[MozAPI#links] options: #{options[:Offset]}"
    req_url = "http://lsapi.seomoz.com/linkscape/links/#{URI::encode(target_url)}?#{options.to_query}" 

    response = HTTParty.get(req_url, :headers => {"User-Agent" => 'node-linkscape (https://github.com/mjp/node-linkscape)'})
    json = JSON.parse response.body
    puts "[MozAPI#links] links returned: #{json.size}"
    
    json
  end
  
  # private 
  def calculate_signature(expires)
    signature = "#{@api_id}\n#{expires}"
    digest = OpenSSL::HMAC.digest('sha1', @api_key, signature)
        
    b64 = Digest::HMAC.base64digest(signature, @api_key, Digest::SHA1)
    CGI::escape(Base64.encode64(digest).chomp)
  end
end