Pod::Spec.new do |s|
  s.name         = 'CBWAlertSheet'
  s.version      = '0.0.1'
  s.license      = 'MIT'
  s.homepage     = 'A custom AlertSheet that can modify color'
  s.homepage     = "https://github.com/xeroxmx/CBWAlertSheet"
  s.license      = "MIT"
  s.author             = { "codeChenBW" => "861754186@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/xeroxmx/CBWAlertSheet", :tag => "0.0.1" }
  s.source_files  = 'CBWAlertSheet/*.{h,m}'
  s.requires_arc = true

end