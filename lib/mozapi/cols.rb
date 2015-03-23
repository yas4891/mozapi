
module MozAPI
  module Cols
    # there is a global limit on the Mozscape API that only lets you 
    # retrieve 100,000 links for any URL
    GLOBAL_LIMIT = 100000
    
    LIMIT = 100
    
    # defined 
    
    
    URL                      = 4
    # lt
    ANCHOR_TEXT              = 4
    # lnt
    ANCHOR_TEXT_NORMALIZED   = 8
    ROOT_DOMAIN              = 16
    # uipl - not in the free version
    LINKING_ROOT_DOMAINS     = 1024
    # uid
    LINKS                    = 2048
    # upa
    PAGE_AUTHORITY           = 34359738368
    # pda
    DOMAIN_AUTHORITY         = 68719476736
    # pib
    LINKING_C_BLOCKS         = 36028797018963968
    
    # URL + root_domain + page_authority + domain_authority
    DEFAULT_SOURCE_COLS      = URL + ROOT_DOMAIN + PAGE_AUTHORITY + DOMAIN_AUTHORITY
    # URL + root_domain
    DEFAULT_TARGET_COLS      = URL + ROOT_DOMAIN
    # anchor_text
    DEFAULT_LINK_COLS        = ANCHOR_TEXT_NORMALIZED
    # linking root domains + links + DA
    DEFAULT_URL_METRICS_COLS = LINKING_ROOT_DOMAINS + LINKS + DOMAIN_AUTHORITY + LINKING_C_BLOCKS
    
  end
end