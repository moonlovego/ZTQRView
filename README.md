# ZTQRView

因为曾经在网上找了很多二维码的第三方库，虽然功能强大，但是使用比较繁琐，

于是自己写了一下，满足简单扫码需求，后期有时间会继续更新，希望会起到的一点点作用 😝 

如果起到作用，就请赞一个，谢谢~

基于 AVFoundation 简单的封装了一下二维码的功能

下面简单的介绍一下使用方法

在所需使用二维码工具的地方导入头文件

#import "ZTQRViewController.h"

然后通过事件触发，直接push即可

[self.navigationController pushViewController:[[ZTQRViewController alloc] init] animated:YES];
