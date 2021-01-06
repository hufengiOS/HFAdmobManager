#
# Be sure to run `pod lib lint HFAdmobManager.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HFAdmobManager'
  s.version          = '0.0.1'
  s.summary          = '加载谷歌广告'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

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
#  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
#  valid_archs = ['armv7s','arm64','x86_64','armv7','arm64e']
#  s.user_target_xcconfig = { 'OTHER_LDFLAGS' => '-lObjC' }
  
  s.requires_arc = true
    
#  s.public_header_files = 'HFAdmobManager/Classes/HFAdmobManager/HFAdmobManagerHeader.h'
  
  #   s.public_header_files = 'Pod/Classes/**/*.h'
#  s.source_files = 'HFAdmobManager/Classes/HFAdmobManager/*.{h,m,pch}'
  
  s.source_files = 'HFAdmobManager/Classes/*'
  s.subspec 'VSAdCache' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSAdCache/*.{h,m}'
  end
  s.subspec 'VSAdConfig' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSAdConfig/*.{h,m}'
  end
#
  s.subspec 'VSAdLoader' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSAdLoader/*.{h,m}'
  end
#
  s.subspec 'VSAdShow' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSAdShow/*.{h,m}'
  end
#
  s.subspec 'VSAdTemplate' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSAdTemplate/*.{h,m,xib}'
  end
#
  s.subspec 'VSGlobalConfigManager' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/VSGlobalConfigManager/*.{h,m}'
  end
  s.subspec 'Other' do |ss|
    ss.source_files = 'HFAdmobManager/Classes/Other/*.{h,m}'
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
