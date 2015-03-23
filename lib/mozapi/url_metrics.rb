require 'httparty'
require 'open-uri'
require 'openssl'
require 'cgi'

module MozAPI
  class URLMetrics < MozAPI::Base
    
    debug_output $stdout 
    def get(target_url, options = {})
      expires = expiration_time
      
      options = {
        AccessID: api_id,
        Expires: expires,
        Signature: calculate_signature(expires),
        Cols: DEFAULT_URL_METRICS_COLS
      }.merge(options)
      
      
      unless target_url.is_a? Array
        req_url = "/url-metrics/#{URI::encode(target_url)}?#{options.to_query}"
        
        puts req_url
        response = self.class.get(req_url, :headers => {"User-Agent" => 'node-linkscape (https://github.com/mjp/node-linkscape)'})
        
        raise "unknown endpoint for URL: #{req_url}" if 404 == response.code
        json = JSON.parse response.body
        puts "[MozAPI#links] links returned: #{json.size}"
        json
      end
    end
  end
end