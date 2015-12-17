Pod::Spec.new do |s|
  s.name             = "DaisyChain"
  s.version          = "1.0.0"
  s.summary          = "Easy animation chaining."
  s.description      = <<-DESC
  DaisyChain is a micro framework which makes UIView animations chaining dead simple. It uses the exact same interface you are familiars with.
                       DESC
  s.homepage         = "https://github.com/alikaragoz/DaisyChain"
  s.license          = "MIT"
  s.author           = { "Ali Karagoz" => "mail@alikaragoz.net" }
  s.social_media_url = "https://twitter.com/alikaragoz"
  s.platform         = :ios, "8.0"
  s.source           = { :git => "https://github.com/alikaragoz/DaisyChain.git", :tag => s.version.to_s }
  s.source_files     = "DaisyChain/DaisyChain.swift"
end
