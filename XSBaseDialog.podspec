Pod::Spec.new do |s|
  #名称
  s.name             = "XSBaseDialog"    
  #版本号
  s.version          = "1.1.0"             
  #简短介绍
  s.summary          = "肥牛 基础弹窗"  
  #详细介绍   
  s.description      = <<-DESC
                       肥牛 基础弹窗
                       DESC
  #主页,这里要填写可以访问到的地址，不然验证不通过
  s.homepage         = "https://github.com/waterhxs"                           
  #截图
  # s.screenshots     = "www.example.com/screenshots_1", "www.example.com/screenshots_2"           
  #开源协议
  s.license          = 'MIT'              
  #作者信息
  s.author           = { "waterh_xs" => "waterh_xs@163.com" }                   
  #项目地址，这里不支持ssh的地址，验证不通过，只支持HTTP和HTTPS，最好使用HTTPS
  s.source           = { :git => "https://gitee.com/waterh_xs/xsbase-dialog.git", :branch => "master" }
  #多媒体介绍地址     
  # s.social_media_url = 'https://twitter.com/'                       

  #支持的平台及版本
  s.platform     = :ios, '10.0'
  #是否使用ARC，如果指定具体文件，则具体的问题使用ARC 
  #s.requires_arc = true

  s.swift_versions = ['5.0']                


  #################################################
  # Toast And Dialog
  #################################################

  s.subspec 'XSBaseDialog' do |dialog|      
    dialog.platform     = :ios, '10.0'
    dialog.ios.source_files = 'XSBaseDialog/Dialog/*.swift'
    dialog.frameworks = 'UIKit'
  end

end
