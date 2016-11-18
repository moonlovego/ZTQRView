# ZTQRView

基于 AVFoundation 简单的封装了一下二维码的功能，后续有时间会继续更新，希望能够得到大神的指点 😄

下面简单的介绍一下使用方法

在所需使用二维码工具的地方导入头文件

#import "ZTQRViewController.h"

然后通过事件触发，直接push即可

[self.navigationController pushViewController:[[ZTQRViewController alloc] init] animated:YES];
