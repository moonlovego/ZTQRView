//
//  ZTQRView.m
//  ZTQCode
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 itServer. All rights reserved.
//

#import "ZTQRView.h"

@interface ZTQRView ()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIImageView *lineImageView;
@property (nonatomic,strong) NSTimer *timer;
@end

@implementation ZTQRView

/**
 *  重写该方法,将设置视图主layer的创建类型
 *
 *  @return AVCaptureVideoPreviewLayer 特殊的layer 可以展示输入设备采集到的信息
 */
+ (Class)layerClass {
    return [AVCaptureVideoPreviewLayer class];
}

- (void)setSession:(AVCaptureSession *)session {
    _session = session;
    AVCaptureVideoPreviewLayer *layer = (AVCaptureVideoPreviewLayer *) self.layer;
    layer.session = session;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void) setupUI {
    //图片的宽高
    CGFloat imageWH = 280;
    
    //设置背景图片
    self.imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pick_bg"]];
    
    //设置位置为界面中间
    _imageView.frame = CGRectMake((self.bounds.size.width - imageWH) * 0.5, (self.bounds.size.height  - imageWH )* 0.5, imageWH, imageWH);
    
    //添加到视图上
    [self addSubview:_imageView];
    
    //初始化二维码扫描线的位置
    _lineImageView = [[UIImageView alloc] initWithFrame:CGRectMake(30, 10, 220, 2)];
    
    //添加图片
    _lineImageView.image = [UIImage imageNamed:@"line"];
    
    //添加到背景视图上
    [_imageView addSubview:_lineImageView];
    
    //开启定时器
    _timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(animation) userInfo:nil repeats:YES];
}

- (void) animation {
    
    //设置动画
    [UIView animateWithDuration:2.8 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        //向下滑动
        _lineImageView.frame = CGRectMake(30, 260, 220, 2);
    } completion:^(BOOL finished) {
        
        //归位
        _lineImageView.frame = CGRectMake(30, 10, 220, 2);
    }];
}

@end








