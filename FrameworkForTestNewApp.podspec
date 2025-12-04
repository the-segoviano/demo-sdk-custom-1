
Pod::Spec.new do |spec|

  spec.name         = "FrameworkForTestNewApp"
  spec.version      = "1.0.0"
  spec.summary      = "A really project of collaboration around the world."
  spec.description  = <<-DESC
  Framework that includes generic tools to be used in each SDK implemented by Trader
                   DESC
  spec.homepage     = "https://sistemasinfraestructuraupx.jfrog.io/"
  spec.license      = "MIT"
  spec.author       = "Luis Segoviano"
  spec.platform      = :ios, "17.4"
  spec.swift_version = '5.7.2'
  spec.source       = { :git => "git@github.com:the-segoviano/demo-sdk-custom-1.git", :tag => "#{spec.version}" }
  # spec.source        = { :git => "https://git-codecommit.us-east-1.amazonaws.com/v1/repos/trader-ios-sdk-survey", :branch => ENV['APP_ENVIRONMENT'] }
  spec.source_files  = "FrameworkForTestNewApp/**/*.{swift,plist}"
  #spec.resources     = "FrameworkForTestNewApp/**/*.{xib,h,json,pdf,png,svg,strings,storyboard}"
  #spec.resource_bundles =  {'FrameworkForTestNewApp' => ['FrameworkForTestNewApp/**/*.{xib,xcassets,json,pdf,png,svg,strings,storyboard}']}

  # spec.dependency 'Alamofire', '4.9.1'
  # spec.dependency 'CryptoSwift'
  # spec.dependency 'lottie-ios', '4.5.0'
  # spec.dependency 'FSCalendar','~> 2.8.4'
  # spec.dependency 'EFQRCode', '~> 6.2.0'
  # spec.dependency 'SDWebImageWebPCoder', '0.14.6'
  # spec.dependency 'DropDown', '2.3.13'
  # spec.dependency 'AdvancedPageControl', '0.9.0'
  # spec.dependency 'RealmSwift', '10.7.7'
  # spec.dependency 'TraderUtils', '1.2.3'
  # spec.dependency 'TraderEvaluator', '1.0.2'
  # spec.dependency 'TraderQrs', '1.3.3'
  # spec.dependency 'TraderFirebaseManager', '1.0.7'
  # spec.dependency 'TraderCambaceo', '1.0.12'
  # spec.dependency 'TraderCoreDesignSystem', '1.0.5'
  # spec.dependency 'UPAXNetworking', '1.7.0'
  # spec.dependency 'UPAXSQLite', '1.2.1'

  spec.static_framework = true

end
