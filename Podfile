source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'

use_frameworks!
#inhibit_all_warnings!

#配置workspace路径
workspace 'OCTest.xcworkspace'

################# 三方依赖
# 公有
def workspace_pods
#  pod 'YYModel'
end

# 主工程
def project_only_pods
  pod 'Masonry'
  pod 'ReactiveObjC', '3.1.1'
  pod 'UMengAnalytics', '4.2.4'
  pod 'Bugly', '2.5.71'
  pod 'Bugtags', '3.2.3'
end

#网络
def network_layer_pods
#  pod 'AFNetworking'
  pod 'AFNetworking', :git => 'https://github.com/xiaohuiCoding/AFNetworking' #DIY一下
  pod 'SDWebImage'
end

################# 模块
target 'XHBaseModule' do
  #配置library路径
  project '/Users/apple/Desktop/XHBaseModule/XHBaseModule.xcodeproj' # 方式一
#  project 'OCTest/XHBaseModule.xcodeproj' # 方式二
  
  workspace_pods
  network_layer_pods
end

# 组件工程目录不会生成Products、Pods、Frameworks文件夹！组件内部无法调用主工程依赖的外部库，有待继续研究！
# 采用方式二需加上下面的指令可消除执行 pod install 后本地组件的警告！
#install! 'cocoapods',
#         :integrate_targets => false

################# 主工程
target 'OCTest' do
  workspace_pods
  project_only_pods
  network_layer_pods
end

