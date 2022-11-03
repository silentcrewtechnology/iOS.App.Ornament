Pod::Spec.new do |s|
  s.name             = 'Ornament'
  s.version          = '0.1.0'
  s.summary          = 'Design system for ABOL'
  s.homepage         = 'https://gitlab.akbars.tech/abo/design.ios'
  s.license          = { :type => 'wtfpl' }
  s.author           = 'Alexey Titov'
  s.source           = { :git => 'https://gitlab.akbars.tech/abo/design.ios.git', :tag => s.version.to_s }
  s.swift_version    = '5.0'

  s.ios.deployment_target = '12.0'
  s.source_files = 'Ornament/Ornament/**/*'
  s.frameworks = 'UIKit'

end