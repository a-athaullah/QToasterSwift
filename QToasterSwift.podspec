Pod::Spec.new do |s|

  s.name         = "QToasterSwift"
  s.version      = "0.0.3"
  s.summary      = "Simple Swift in App toast notification"

  s.description  = <<-DESC
                    Simple Swift in App toast notification
                 DESC

  s.homepage     = "http://qisc.us"

  s.license      = "MIT"
  s.author       = "Ahmad Athaullah"

  s.source       = { :git => "https://github.com/a-athaullah/QToasterSwift.git", :tag => "#{s.version}" }


  s.source_files  = "QToasterSwift/QToasterSwift/*.swift"
  s.platform      = :ios, "8.3"

  s.dependency "AlamofireImage", "~> 2.4"

end
