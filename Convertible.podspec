Pod::Spec.new do |s|
  s.name         = "Convertible"
  s.version      = "1.0.0"
  s.summary      = "Swift Framework For Converting Any Type Between JSON, Data And More"
  s.description  = <<-DESC
                   Converting your basic types and models to and from JSON, Data, etc. is a common task in application development.
                   Convertible defines a set of protocols and implementations that makes the conversion process easy, so you don't have to write boilerplate code.
                   DESC
  s.homepage     = "https://github.com/bradhilton/Convertible"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Brad Hilton" => "brad@skyvive.com" }
  s.source       = { :git => "https://github.com/bradhilton/Convertible.git", :tag => "1.0.0" }

  s.ios.deployment_target = "7.0"
  s.osx.deployment_target = "10.9"

  s.source_files  = "Convertible", "JsonObject/**/*.{swift,h,m}"
  s.requires_arc = true
end
