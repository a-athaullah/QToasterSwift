Pod::Spec.new do |s|

  s.name         = "QToasterSwift"
  s.version      = "0.2.0"
  s.summary      = "Simple Swift in App toast notification"

  s.description  = <<-DESC
                    QToasterSwift is small and simple library to show in app notification (toaster) with capability to customize toaster appearance.
                 DESC

  s.homepage     = "http://qisc.us"

  s.license      = "MIT"
  s.author       = "Ahmad Athaullah"

  s.source       = { :git => "https://github.com/a-athaullah/QToasterSwift.git", :tag => "#{s.version}" }


  s.source_files  = "QToasterSwift/QToasterSwift/*.swift"
  s.platform      = :ios, "8.3"

end
