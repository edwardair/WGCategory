Pod::Spec.new do |s|
  s.name         = "WGKit"
  s.version      = "0.5.2"
  s.summary      = "WGKit"
  s.description  = <<-DESC
                   常用组件封装
                   DESC
  s.homepage     = "https://github.com/edwardair/WGTest.git"
  s.license      = "LICENSE"
  s.author       = { "Eduoduo" => "550621009@qq.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/edwardair/WGCategory.git", :tag => s.version}
  s.requires_arc = true
  s.ios.frameworks = 'Foundation', 'UIKit'

  s.source_files  = [
    'WGKit/WGDefines.h'
  ]
  s.public_header_files = [
    'WGKit/WGDefines.h'
  ]
  
  s.subspec 'Constant' do |ss|
    ss.source_files  = 'WGKit/WGConstant.h'
    ss.public_header_files  = 'WGKit/WGConstant.h'
  end

  s.subspec 'Core' do |ss|
    ss.dependency 'WGKit/Constant'
    ss.source_files  = 'WGKit/Core/*.{h,m}'
    ss.public_header_files  = 'WGKit/Core/*.{h}'
  end
  
  s.subspec 'UIKit' do |ss|
    ss.subspec 'Category' do |sss|
      sss.source_files  = 'WGKit/UIKit/Category/*.{h,m}'
    end
    ss.subspec 'View' do |sss|
      sss.dependency 'WGKit/Core'
      sss.dependency 'WGKit/Constant'
      sss.dependency 'WGKit/UIKit/Category'
      sss.source_files  = 'WGKit/UIKit/View/*.{h,m}'
      sss.subspec 'WGTableController' do |ssss|
        ssss.source_files  = 'WGKit/UIKit/View/WGTableController/*.{h,m}'
      end
    end
  end

  s.subspec 'WGJSONModel' do |ss|
    ss.dependency 'WGKit/Core'
    ss.source_files  = 'WGKit/WGJSONModel/*.{h,m}'
  end
  
  s.subspec 'Other' do |ss|
    ss.dependency 'WGKit/Constant'
    ss.dependency 'WGKit/Core'
    ss.dependency 'WGKit/UIKit/Category'
    ss.source_files  = 'WGKit/Other/*.{h,m}'
  end
end
