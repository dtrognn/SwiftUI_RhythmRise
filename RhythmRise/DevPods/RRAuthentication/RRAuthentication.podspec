#
# Be sure to run `pod lib lint RRAuthentication.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RRAuthentication'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RRAuthentication.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/dtrognn/RRAuthentication'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dtrognn' => 'dtrognn@gmail.com' }
  s.source           = { :git => 'https://github.com/dtrognn/RRAuthentication.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '16.0'

  s.source_files = 'RRAuthentication/**/*.{swift,h,m}'
  s.resources = 'RRAuthentication/**/*.{png,xcassets,json,ttf,txt,storyboard,xib,xcdatamodeld,strings}'

end
