#
# Be sure to run `pod lib lint RRAPILayer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RRAPILayer'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RRAPILayer.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/dtrognn/RRAPILayer'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dtrognn' => 'dtrognn@gmail.com' }
  s.source           = { :git => 'https://github.com/dtrognn/RRAPILayer.git', :tag => s.version.to_s }

  s.ios.deployment_target = '16.0'

  s.source_files = 'RRAPILayer/**/*.{swift,h,m}'
  s.resources = 'RRAPILayer/**/*.{png,xcassets,json,ttf,txt,storyboard,xib,xcdatamodeld,strings}'

  s.dependency 'RRCore'

end
