//
//  LTNavViewController.m
//  webViewNav
//
//  Created by Felix on 2017/6/16.
//  Copyright © 2017年 Felix. All rights reserved.
//

#import "LTNavViewController.h"
#import "UINavigationBar+Awesome.h"

@interface LTNavViewController ()<UIWebViewDelegate,UIScrollViewDelegate>



@end

@implementation LTNavViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.navigationController.navigationBar lt_reset];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.navigationController.navigationBar.translucent = NO;
    [self setupUI];
}

- (void)setupUI {
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIWebView *webview = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64)];
    [webview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://baidu.com"]]];
    webview.delegate = self;
    webview.scrollView.delegate = self;
    [self.view addSubview:webview];
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0 , width, 64)];
    [self.view addSubview:view];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY > 0) {
        if (offsetY >= 44) {
            [self setNavigationBarTransformProgress:1];
        } else {
            [self setNavigationBarTransformProgress:(offsetY / 44)];
        }
    } else {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
    }
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress {
    [self.navigationController.navigationBar lt_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar lt_setElementsAlpha:(1-progress)];
}

@end
