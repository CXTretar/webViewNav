//
//  BLKViewController.m
//  webViewNav
//
//  Created by Felix on 2017/5/31.
//  Copyright © 2017年 Felix. All rights reserved.
//

#import "BLKViewController.h"

#import "SquareCashStyleBar.h"
#import "FacebookStyleBarBehaviorDefiner.h"
#import "BLKDelegateSplitter.h"
#import "FacebookStyleBar.h"

@interface BLKViewController ()<UIWebViewDelegate,UIScrollViewDelegate>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic) FacebookStyleBar *myCustomBar;
@property (nonatomic) BLKDelegateSplitter *delegateSplitter;

@end

@implementation BLKViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNeedsStatusBarAppearanceUpdate];
    [self addWebView];
    // Setup the bar
    self.myCustomBar = [[FacebookStyleBar alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];
    
    FacebookStyleBarBehaviorDefiner *behaviorDefiner = [[FacebookStyleBarBehaviorDefiner alloc] init];
    [behaviorDefiner addSnappingPositionProgress:0.0 forProgressRangeStart:0.0 end:40.0/(105.0-20.0)];
    [behaviorDefiner addSnappingPositionProgress:1.0 forProgressRangeStart:40.0/(105.0-20.0) end:1.0];
    behaviorDefiner.snappingEnabled = YES;
    behaviorDefiner.thresholdNegativeDirection = 140.0;
    
    
    self.delegateSplitter = [[BLKDelegateSplitter alloc]initWithFirstDelegate:behaviorDefiner secondDelegate:self];
    
    self.webView.scrollView.delegate = (id<UITableViewDelegate>)self.delegateSplitter;
    self.myCustomBar.behaviorDefiner = behaviorDefiner;
    self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.myCustomBar.maximumBarHeight, 0.0, 49, 0.0);
    [self.webView.scrollView setContentOffset:CGPointMake(0, -self.myCustomBar.maximumBarHeight) animated:YES];
    self.webView.scalesPageToFit = YES;
    [self.view addSubview:self.myCustomBar];
    
    [self.myCustomBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)addWebView {
    self.view.backgroundColor = [UIColor whiteColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIView *view = view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0.f)];
    view.backgroundColor = [UIColor redColor];
    
    self.webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 0, width, height)];
    NSLog(@"%@", NSStringFromCGRect(self.webView.frame));
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    
    [self.view addSubview:self.webView];
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, height- 49, width, 49)];
    bottomview.backgroundColor = [UIColor whiteColor];
    bottomview.alpha = 0.8;
    [self.view addSubview:bottomview];

    
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if ([keyPath isEqualToString:@"frame"]) {
        NSLog(@"self.moveView.y = %f", self.myCustomBar.frame.size.height);
        
//        self.webView.scrollView.contentInset = UIEdgeInsetsMake(self.myCustomBar.frame.size.height, 0.0, 49, 0.0);
    }
    
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self.webView.scrollView setContentOffset:CGPointMake(0, -self.myCustomBar.maximumBarHeight) animated:YES];
}

-(void)dealloc {
    [self.myCustomBar removeObserver:self forKeyPath:@"frame"];
}

@end
