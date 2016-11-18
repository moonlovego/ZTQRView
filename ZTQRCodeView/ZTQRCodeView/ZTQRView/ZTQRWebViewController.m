//
//  ZTQRWebViewController.m
//  ZTQCode
//
//  Created by apple on 16/11/18.
//  Copyright © 2016年 itServer. All rights reserved.
//

#import "ZTQRWebViewController.h"

@interface ZTQRWebViewController ()

@end

@implementation ZTQRWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationView];
    [self loadWebView];
}

- (void) setNavigationView {
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"关闭" style:UIBarButtonItemStylePlain target:self action:@selector(dismissQRController)];
}

- (void) dismissQRController {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"dismissQRController" object:nil];
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void) loadWebView {
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:_urlString]]];
    [self.view addSubview:webView];
}

@end
