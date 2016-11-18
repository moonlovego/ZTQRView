//
//  ViewController.m
//  ZTQCode
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 itServer. All rights reserved.
//

#import "ZTQRViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <SafariServices/SafariServices.h>
#import "ZTQRView.h"
#import "ZTQRWebViewController.h"

@interface ZTQRViewController () <AVCaptureMetadataOutputObjectsDelegate>

//输入的摄像头
@property (nonatomic,strong) AVCaptureDeviceInput *inputDevice;

//输出设备 二维码算法的数据结果 元数据
@property (nonatomic,strong) AVCaptureMetadataOutput *outputMetadata;

//回话管理输入设备
@property (nonatomic,strong) AVCaptureSession *session;

//预览
@property (nonatomic,strong) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation ZTQRViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNavigationView];
    
    [self setupUI];
    
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dismissQRController:) name:@"dismissQRController" object:nil];
}

/**
 *  设置导航栏
 */
- (void) setNavigationView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:self action:@selector(cancelBtnClick)];
}

/**
 *  返回主页
 */
- (void) cancelBtnClick {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  设置界面
 */
- (void) setupUI {
    //输入设备  摄像头
    //设置输入设备类型
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    self.inputDevice = [AVCaptureDeviceInput deviceInputWithDevice:device error:nil];
    
    //输出设备
    self.outputMetadata = [[AVCaptureMetadataOutput alloc] init];
    
    //输出设备的类型必须再输出设备添加到回话以后设置
    //取出数据 设置输出设备
    [self.outputMetadata setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    self.session = [[AVCaptureSession alloc] init];
    
    //添加输入输出设备到回话中
    if ([self.session canAddInput:_inputDevice]) {
        [self.session addInput:_inputDevice];
    }
    if ([self.session canAddOutput:_outputMetadata]) {
        [self.session addOutput:_outputMetadata];
    }
    
    //设置输出设备的类型
    self.outputMetadata.metadataObjectTypes = @[AVMetadataObjectTypeQRCode];
    
    //自定义view
    ZTQRView *preview = [[ZTQRView alloc] initWithFrame:self.view.bounds];
    
    preview.session = self.session;
    
    [self.view addSubview:preview];
    
    [self.session startRunning];
}

/**
 *  重新开启会话
 *
 *  @param noti
 */
- (void) dismissQRController:(NSNotification *) noti {
    [self.session startRunning];
}

/**
 *  获取二维码信息
 *
 *  @param captureOutput
 *  @param metadataObjects
 *  @param connection
 */
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    
    for (id metadata in metadataObjects) {
        if ([[metadata stringValue] hasPrefix:@"http"]) {//判断是一个网页
            //创建跳转控制器
            ZTQRWebViewController *rootViewController = [[ZTQRWebViewController alloc] init];
            
            //设置url
            rootViewController.urlString = [metadata stringValue];
            
            //创建导航控制器
            UINavigationController *navigationViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
            
            //弹出新控制器
            [self presentViewController:navigationViewController animated:YES completion:nil];
            [self.session stopRunning];
            return;
        } else {
            NSLog(@"%@",[metadata stringValue]);
        }
    }
    
}

@end
