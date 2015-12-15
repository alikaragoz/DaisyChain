Pod::Spec.new do |s|
  s.name             = "DaisyChain"
  s.version          = "1.0.0"
  s.summary          = "Serially perform animations."
  s.description      = <<-DESC
  DaisyChain is a simple library which allows you to perform animation in a serial way.
                       DESC
  s.homepage         = "https://github.com/alikaragoz/DaisyChain"
  s.license          = "MIT"
  s.author           = { "Ali Karagoz" => "mail@alikaragoz.net" }
  s.social_media_url = "https://twitter.com/alikaragoz"
  s.platform         = :ios, "8.0"
  s.source           = { :git => "https://github.com/alikaragoz/DaisyChain.git", :tag => s.version.to_s }
end
