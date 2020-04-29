#
# Be sure to run `pod lib lint QuickDB.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QuickDB'
  s.version          = '2.0.0'
  s.summary          = 'Fast usage dataBase to avoid struggling with dataBase complexity. Just save every object with a simple function.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'The QuickDB uses CoreData with a SUPER easy use case that you can store any codable objects and query for them in just 1 line of code.\nThis component is highly recommended for small scale applications to store user data and settings with custom class types.'
                       DESC

  s.homepage         = 'https://github.com/behrad-kzm/QuickDB'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  
  s.source_files  = 'QuickDB/Classes/Utils/DataBase.xcdatamodeld', 'QuickDB/Classes/Utils/DataBase/*.xcdatamodeld', 'QuickDB/Classes/**/*.{h,m,swift,xcdatamodeld}'
  s.resources = ['QuickDB/Classes/Utils/DataBase.xcdatamodeld']
  s.preserve_paths = 'QuickDB/Classes/Utils/DataBase.xcdatamodeld'
  
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'behrad-kzm' => 'behradkzm@gmail.com' }
  s.source           = { :git => 'https://github.com/behrad-kzm/QuickDB.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '11.0'
	s.swift_versions = '5.0'
  
  # s.resource_bundles = {
  #   'QuickDB' => ['QuickDB/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
