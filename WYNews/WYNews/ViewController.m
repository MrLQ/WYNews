//
//  ViewController.m
//  WYNews
//
//  Created by LiQuan on 16/5/13.
//  Copyright © 2016年 LiQuan. All rights reserved.
//

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height


#import "ViewController.h"
#import "NavigationView.h"

@interface ViewController ()<NavigationViewDelegate>

@property (nonatomic ,strong) UIView * headView;

@property (nonatomic ,strong) NavigationView * titleView;

@property (nonatomic ,strong) UIScrollView * scrollView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.headView];
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];

}


-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    CGPoint  offset = [change[NSKeyValueChangeNewKey] CGPointValue];
    self.titleView.offsetScale = offset.x/kScreenWidth;
}

#pragma mark NavigationViewDelegate
- (void)buttonClickWithType:(PositonType)actionType
{
    [self.scrollView setContentOffset:CGPointMake(actionType * kScreenWidth, 0) animated:YES];
}

#pragma mark  create UI
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, 64)];
        _headView.backgroundColor = kRedColor;
    }
    return _headView;
}


- (NavigationView *)titleView
{
    if(!_titleView)
    {
        _titleView = [[NavigationView alloc]initWithFrame:CGRectMake(kScreenWidth/4, 24, kScreenWidth/2, 36)];
        _titleView.delegate = self;
    }
    return _titleView;
}

- (UIScrollView *)scrollView
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64)];
        _scrollView.contentSize = CGSizeMake(kScreenWidth*2, kScreenHeight - 64);
        _scrollView.pagingEnabled = YES;
        for (NSInteger i = 0; i < 2; i ++) {
            UIView * view = [[UIView alloc]initWithFrame:CGRectMake(kScreenWidth * i, 0, kScreenWidth, kScreenHeight - 64)];
            view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255. green:arc4random()%255/255. blue:arc4random()%255/255. alpha:1];
            [_scrollView addSubview:view];
        }
    }
    return _scrollView;

}


#pragma mark - manage memory methods

-(void)dealloc
{
    [self.scrollView removeObserver:self forKeyPath:@"contentOffset"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
