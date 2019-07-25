Pod::Spec.new do |s|
  s.name = 'GMSLibrary'
  s.ios.deployment_target = '10.0'
  s.osx.deployment_target = '10.12'
  s.tvos.deployment_target = '10.0'
  s.version = '0.8.5'
  s.source = { :git => 'git@git.scm.genesys.com:ciwong/gms-swift-client.git' }
  s.authors = 'Swagger Codegen'
  s.license = 'Proprietary'
  s.homepage = 'https://git.scm.genesys.com/ciwong/gms-swift-client'
  s.summary = 'GMS 8.5 client'
  s.description = 'SDK for Genesys PureEngage (Premise) GMS 8.5.1 in Swift.'
  s.source_files = 'GMSLibrary/Classes/**/*.swift'
  s.dependency 'Alamofire', '~> 4.8.0'
  s.dependency 'GFayeSwift', '~> 0.5.5'
  s.dependency 'PromisesSwift'
  s.swift_versions = [ "4.0", "4.2", "5.0" ]
end
