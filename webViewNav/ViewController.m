//
//  ViewController.m
//  webViewNav
//
//  Created by Felix on 2017/5/26.
//  Copyright © 2017年 Felix. All rights reserved.
//

#import "ViewController.h"
#import <TLYShyNavBar/TLYShyNavBarManager.h>
#import <WebKit/WebKit.h>
#import <BLKFlexibleHeightBar.h>
#import <SquareCashStyleBehaviorDefiner.h>
#import <GTScrollNavigationBar.h>

@interface ViewController ()<UIScrollViewDelegate,UIWebViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property (nonatomic, strong) UIWebView *webView;
@property (nonatomic, strong) UICollectionView *collectionView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupPageCollectionView];
//     self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor blackColor];
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    
    UIView *view = view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 0.f)];
    view.backgroundColor = [UIColor redColor];
    
    UIView *currentView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, width, height - 64 -49)];
    
    
    self.webView = [[UIWebView alloc]initWithFrame:currentView.bounds];
    self.webView.delegate = self;
    self.webView.scrollView.delegate = self;
    NSURL *url = [NSURL URLWithString:@"https://www.baidu.com/"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:request];
    [currentView addSubview:self.webView];
    
    [self.view addSubview:currentView];
    
    UIView *bottomview = [[UIView alloc]initWithFrame:CGRectMake(0, height- 49, width, 49)];
    bottomview.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:bottomview];
    
    
    
    
}

- (void)setupPageCollectionView {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    CGFloat height = [UIScreen mainScreen].bounds.size.height;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(width, height - 49);
    layout.minimumLineSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
   
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, width, height - 49) collectionViewLayout:layout];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.pagingEnabled = YES;
    _collectionView.backgroundColor = [UIColor clearColor];
    _collectionView.alwaysBounceHorizontal = YES;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"UICollectionViewCell"];
    _collectionView.showsHorizontalScrollIndicator = NO;
        [self.view addSubview:_collectionView];
//    self.automaticallyAdjustsScrollViewInsets = YES;

}


#pragma mark - UIWebViewDelegate
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.navigationController.scrollNavigationBar.scrollView = self.webView.scrollView;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.navigationController.scrollNavigationBar resetToDefaultPositionWithAnimation:YES];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView
{
    [self.navigationController.scrollNavigationBar resetToDefaultPositionWithAnimation:YES];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 10;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"UICollectionViewCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
