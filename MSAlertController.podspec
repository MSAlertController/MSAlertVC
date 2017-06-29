Pod::Spec.new do |s|
  s.name         = "MSAlertVC"
  s.version      = "1.0.0"
  s.summary      = "一个高仿微博和微信的底部弹窗"
  s.description  = <<-DESC
                    MSAlertController的初始化仿照系统的UIAlertController，但是点击事件放在了同一个block中，代码更简洁
                   DESC
  s.homepage     = "https://github.com/MSAlertController/MSAlertVC"
  s.license      = "MIT"
  s.author       = { "MSAlertController" => "wxh_apples@163.com" }
  s.source       = { :git => "https://github.com/MSAlertController/MSAlertVC.git", :tag => "#{s.version}" }
  s.ios.deployment_target = '8.0'
  s.platform     = :ios
  s.source_files = 'MSAlertController'
  s.requires_arc = true
end