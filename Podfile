# Uncomment the next line to define a global platform for your project
platform :ios, '9.0'

target 'SIMDemo' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  inhibit_all_warnings!
  source 'https://github.com/CocoaPods/Specs.git'
  source 'https://github.com/Thunbu/TBIMSpec.git'

  pod 'TBIMLibrary', '0.0.134' # github 公开
#  pod 'SIMSDK', :path => '../SIMSDK/'
  
  # 个推推送
  pod 'GTSDK', '2.5.5.0-noidfa'
  
  # UI相对布局库
  pod 'Masonry', '~> 1.1.0'
  # 图片加载库
  pod 'SDWebImage', '~> 4.4.2'
  # 自定义指示器HUD
  pod 'MBProgressHUD', '~> 1.1.0'
  
  # 左滑TableCell显示更多操作区
  pod 'MGSwipeTableCell', '~> 1.6.8'
  
  pod 'YYText'
  
  pod 'MJRefresh'
  
  pod 'AFNetworking','~> 4.0.1'
  pod 'YYModel'
  pod 'SocketRocket'
  pod 'RealReachability'
  pod 'ReactiveCocoa', '~> 2.5'
  pod 'MJRefresh'
  pod "Qiniu", "~> 8.1"
  pod 'AliyunOSSiOS', '~> 2.10.7'

  target 'SIMDemoTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SIMDemoUITests' do
    # Pods for testing
  end

end
