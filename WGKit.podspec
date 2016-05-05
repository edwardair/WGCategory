Pod::Spec.new do |s|
  s.name         = "WGKit"
  s.version      = "0.0.2"
  s.summary      = "A short description of WGKit."
  s.description  = <<-DESC
                   A longer description of WGKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "http://EXAMPLE/WGCategory"
  s.license      = "MIT (example)"
  s.author             = { "Eduoduo" => "550621009@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/edwardair/WGCategory.git", :tag => s.version}
  s.requires_arc = true

  s.source_files  = 'WGKit/WGDefines.h'
  s.public_header_files = 'WGKit/WGDefines.h'
  
  # s.default_subspec = 'WGKit'
  
  # s.subspec 'WGKit' do |ss|
  #   ss.source_files  = 'WGKit/WGDefines.h'
  #   ss.public_header_files = 'WGKit/WGDefines.h'
  # end
  
  s.subspec 'Core' do |ss|
    ss.source_files  = 'WGKit/Core/*.{h,m}'
    ss.public_header_files = 'WGKit/Core/*.{h}'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.source_files  = 'WGKit/UIKit/*.{h,m}'
    ss.public_header_files = 'WGKit/UIKit/*.{h}'
  end
  
  s.subspec 'WGJSONModel' do |ss|
    ss.source_files  = 'WGKit/WGJSONModel/*.{h,m}'
    ss.public_header_files = 'WGKit/WGJSONModel/*.{h}'
  end
  
  s.subspec 'Other' do |ss|
    ss.source_files  = 'WGKit/Other/*.{h,m}'
    ss.public_header_files = 'WGKit/Other/*.{h}'
  end
end
