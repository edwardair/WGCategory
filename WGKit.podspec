Pod::Spec.new do |s|
  s.name         = "WGKit"
  s.version      = "0.2.6"
  s.summary      = "A short description of WGKit."
  s.description  = <<-DESC
                   A longer description of WGKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  s.homepage     = "http://EXAMPLE/WGCategory"
  s.license      = "MIT"
  s.author       = { "Eduoduo" => "550621009@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/edwardair/WGCategory.git", :tag => s.version}
  s.requires_arc = true

  s.source_files  = 'WGKit/WGDefines.h'
  s.public_header_files = 'WGKit/WGDefines.h'
  
  s.subspec 'Core' do |ss|
    ss.source_files  = 'WGKit/Core/*.{h,m}'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.subspec 'Category' do |sss|
      sss.source_files  = 'WGKit/UIKit/Category/*.{h,m}'
    end
    ss.subspec 'View' do |sss|
      sss.source_files  = 'WGKit/UIKit/View/*.{h,m}'
      sss.subspec 'WGTableController' do |ssss|
        ssss.source_files  = 'WGKit/UIKit/View/WGTableController/*.{h,m}'
      end
    end
  end

  s.subspec 'WGJSONModel' do |ss|
    ss.source_files  = 'WGKit/WGJSONModel/*.{h,m}'
  end
  
  s.subspec 'Other' do |ss|
    ss.source_files  = 'WGKit/Other/*.{h,m}'
  end
end
