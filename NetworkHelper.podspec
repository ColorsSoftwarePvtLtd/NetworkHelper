
Pod::Spec.new do |s|
  s.name         = "NetworkHelper"
  s.version      = "1.0"
  s.summary      = "This is used to communicate with server for sending and getting data from it"

  s.homepage     = "http://www.colorssoftware.com"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Venkat" => "venkat.varra@gmail.com" }
  s.social_media_url   = "http://twitter.com/VenkatVarra"
  s.platform     = :ios
  s.ios.deployment_target = "8.0"
  s.source       = { :git => "https://github.com/ColorsSoftwarePvtLtd/NetworkHelper.git", :tag => s.version }
  s.source_files  = "NetworkHelper/*.swift"
  
  s.requires_arc = true

end
