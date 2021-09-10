Pod::Spec.new do |s|
  s.name                      = "Netify"
  s.version                   = "1.0.0"
  s.summary                   = "Netify"
  s.homepage                  = "https://github.com/mobilee/Netify"
  s.license                   = { :type => "MIT", :file => "LICENSE" }
  s.author                    = { "Łukasz Szarkowicz" => "szarkowicz@gmail.com" }
  s.source                    = { :git => "https://github.com/mobilee/Netify.git", :tag => s.version.to_s }
  s.swift_version             = "5.1"
  s.ios.deployment_target     = "10.0"
  s.source_files              = "Sources/**/*"
  s.frameworks                = "Foundation"
end
