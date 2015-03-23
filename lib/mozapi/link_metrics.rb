require 'httparty'
require 'open-uri'
require 'openssl'
require 'cgi'

module MozAPI
  class LinkMetrics < MozAPI::Base
    
    def get(target_url, options = {})
      expires = expiration_time
      
      options = {
        Sort: 'page_authority',
        Filter: 'follow+external',
        Scope: 'page_to_page',
        SourceCols: DEFAULT_SOURCE_COLS,
        TargetCols: DEFAULT_TARGET_COLS,
        LinkCols: DEFAULT_LINK_COLS,
        AccessID: api_id,
        Expires: expires,
        Signature: calculate_signature(expires),
        Limit: LIMIT,
        Offset: 0
      }.merge(options)
      
      #puts "[MozAPI#links] options: #{options[:Offset]}"
      req_url = "/links/#{URI::encode(target_url)}?#{options.to_query}" 
  
      response = self.class.get(req_url, :headers => {"User-Agent" => 'node-linkscape (https://github.com/mjp/node-linkscape)'})
      
      raise "unknown endpoint for URL: #{req_url}" if 404 == response.code
      json = JSON.parse response.body
      puts "[MozAPI#links] links returned: #{json.size}"
      
      json
    end
  end
end