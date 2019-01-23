#
#  Be sure to run `pod spec lint LLDialog.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "LLDialog"
  s.version      = "1.2.0"
  s.summary      = "Material design dialog for iOS written in Swift."

  # This description is used to generate tags and improve search results.
  #   * Think: What does it do? Why did you write it? What is the focus?
  #   * Try to keep it short, snappy and to the point.
  #   * Write the description between the DESC delimiters below.
  #   * Finally, don't worry about the indent, CocoaPods strips it!
  s.description  = <<-DESC
    Material design dialog for iOS written in Swift.
  DESC

  s.homepage     = "https://github.com/LiulietLee/LLDialog"
  s.screenshots  = "https://cloud.githubusercontent.com/assets/9763162/12781499/b909ede8-caaf-11e5-8dac-d5fce055aec0.png"
  s.license      = { :type => "MIT", :file => "LICENSE.txt" }
  
  s.author             = { "_liet" => "lee.liuliet@hotmail.com" }
  s.social_media_url   = "https://space.bilibili.com/4056345/"
  
  s.platform         = :ios, "8.0"
  s.source           = { :git => "https://github.com/LiulietLee/LLDialog.git", :tag => "#{s.version}" }
  s.source_files     = "Source"
  s.swift_version    = "4.2"
end
