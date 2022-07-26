# HLSliderView

滑动到最右边验证组件

##### 支持使用CocoaPods引入, Podfile文件中添加:

``` objc
pod 'HLSliderView', '1.0.0'
```

# Demonstration

![image](https://github.com/huangchangweng/HLSliderView/blob/main/QQ20220610-113300.gif)

基本使用方法:<p>

``` objc
HLSliderView *sliderView2 = [[HLSliderView alloc] initWithFrame:CGRectMake(20, 300, [UIScreen mainScreen].bounds.size.width - 40, 44)];
sliderView2.minimumTrackColor = [UIColor systemPinkColor];
sliderView2.isNeedLoadingView = NO;
sliderView2.sliderEndBlock = ^(){
  NSLog(@"拖到最后啦～～");
  // TODO 到服务端验证
};
[self.view addSubview:sliderView2];
```

如果想全局替换HLSliderView的图片资源，可以在工程中新建一个名字为`HLSliderView.bundle`的bundle，参照pod中`HLSliderView.bundle`为图片资源命名。HLSliderView会优先加载当前工程中的图片资源。

# GlobalSetting

如果您项目中多个地方使用到该组件，您可以全局设置样式，例在`AppDelegate`添加

``` objc
[HLSliderView appearance].normalText = @"滑动到最右边验证";
```

> 注意：`代码` > `appearance` > `interface builder`，所以appearance设置的会覆盖在xib或storyboard中设置的属性，当然`代码`会覆盖`appearance`设置

# Requirements

iOS 9.0 +, Xcode 7.0 +

# Version

* 1.0.0 :

  完成HLSliderView基础搭建

# License

HLSliderView is available under the MIT license. See the LICENSE file for more info.
