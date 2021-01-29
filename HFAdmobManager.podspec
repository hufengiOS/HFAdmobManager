#
# Be sure to run `pod lib lint HFAdmobManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'HFAdmobManager'
    s.version          = '0.0.4'
    s.summary          = '添加了测试模式，用测试ID加载广告'
    
    s.description      = <<-DESC
  TODO: Add long description of the pod here.
                         DESC

    s.homepage         = 'https://github.com/hufengiOS/HFAdmobManager'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'hufengiOS' => '1035372726@qq.com' }
    s.source           = { :git => 'https://github.com/hufengiOS/HFAdmobManager.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '9.0'
    
    s.requires_arc = true
    
  
    s.source_files = 'HFAdmobManager/Classes/*'
    s.subspec 'VSAdCache' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSAdCache/*.{h,m}'
    end
    s.subspec 'VSAdConfig' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSAdConfig/*.{h,m}'
    end
  
    s.subspec 'VSAdLoader' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSAdLoader/*.{h,m}'
    end
  
    s.subspec 'VSAdShow' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSAdShow/*.{h,m}'
    end
  
    s.subspec 'VSAdTemplate' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSAdTemplate/*.{h,m}'
    end

    s.subspec 'VSGlobalConfigManager' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/VSGlobalConfigManager/*.{h,m}'
    end
    s.subspec 'Other' do |ss|
        ss.source_files = 'HFAdmobManager/Classes/Other/*.{h,m}'
    end
    
    s.subspec 'Resources' do |ss|
        ss.resources = 'HFAdmobManager/HFAdmobManager.bundle'
    end
    
    
  
    s.frameworks = 'UIKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  
    s.static_framework = true
    
    s.dependency 'Google-Mobile-Ads-SDK'
    s.dependency 'Masonry'
    s.dependency 'MJExtension'
    
    
   # s.dependency 'GoogleMobileAdsMediationFacebook'
   # s.dependency 'GoogleMobileAdsMediationUnity'
    
end
