Pod::Spec.new do |spec|

  spec.name         = "HLSliderView"
  spec.version      = "1.0.0"
  spec.summary      = "一个滑动到最右边验证的Slider"

  # 描述
  spec.description  = <<-DESC
    一个滑动到最右边验证的Slider。可在xib、storyboard上设置属性
  DESC

  # 项目主页
  spec.homepage     = "https://github.com/huangchangweng/HLSliderView"

  # 开源协议
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  # 作者
  spec.author       = { "黄常翁" => "599139419@qq.com" }
  
  # 支持平台
  spec.platform     = :ios, "9.0"

  # git仓库，tag
  spec.source       = { :git => "https://github.com/huangchangweng/HLSliderView.git", :tag => spec.version.to_s }
  
  spec.pod_target_xcconfig = { 'VALID_ARCHS' => 'x86_64 armv7 arm64' }

  # 资源路径
  spec.source_files = "HLSliderView/HLSliderView/*.{h,m}"
  
  # 资源文件目录，可以在此目录下存放图片、xib等资源，可以使用通配符或者{png,jpg,xib}这样的方式来指定文件类型
  spec.resource     = "HLSliderView/HLSliderView/HLSliderView.bundle"

  # 依赖系统库
  spec.frameworks   = "UIKit"

end
