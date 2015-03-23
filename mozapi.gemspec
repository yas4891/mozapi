lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'mozapi/version'

Gem::Specification.new do |s|
  spec = s
  s.name        = 'mozapi'
  s.version     = MozAPI::VERSION
  s.summary     = "A light-weight wrapper around the Mozscape API"
  s.description = "MozAPI is a light-weight wrapper for the MozscapeAPI (http://moz.com/products/api). It currently supports parts of the 'links' endpoint"
  s.authors     = ["Christoph Engelhardt"]
  s.email       = 'christoph@it-engelhardt.de'
  s.homepage    =
    'https://github.com/yas4891/mozapi'
  s.license       = 'MIT'
  
  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  
  s.add_dependency('httparty', '~> 0.13.1')
end