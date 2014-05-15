Gem::Specification.new do |s|
  s.name        = 'mozapi'
  s.version     = '0.1.1'
  s.date        = '2014-05-15'
  s.summary     = "A light-weight wrapper around the Mozscape API"
  s.description = "MozAPI is a light-weight wrapper for the MozscapeAPI (http://moz.com/products/api). It currently supports parts of the 'links' endpoint"
  s.authors     = ["Christoph Engelhardt"]
  s.email       = 'christoph@it-engelhardt.de'
  s.files       = ["lib/mozapi.rb"]
  s.add_dependency('httparty')
  s.homepage    =
    'https://github.com/yas4891/mozapi'
  s.license       = 'MIT'
end