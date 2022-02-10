Pod::Spec.new do |s|
  s.name             = 'RxNMapsMap'
  s.version          = '0.1.0'
  s.summary          = 'RxSwift wrapper for NMapsMap Delegate'
  s.homepage         = 'https://github.com/sseungmn/RxNMapsMap'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'miniOS' => 'seungmin.oh.dev@gmail.com' }
  s.source           = { :git => 'https://github.com/sseungmn/RxNMapsMap.git', :tag => s.version.to_s }

  s.swift_version    = '5.5.0'
  s.ios.deployment_target = '9.0'
  s.source_files = 'RxNMapsMap/Classes/**/*'
  
  s.dependency 'NMapsMap', '~> 3.14.1'
  s.dependency 'RxSwift', '~> 6.5.0'
end
