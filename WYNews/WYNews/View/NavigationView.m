//
//  NavigationView.m
//  WYNews
//
//  Created by LiQuan on 16/5/13.
//  Copyright © 2016年 LiQuan. All rights reserved.
//

#define kWidth  self.frame.size.width
#define kHeight self.frame.size.height

#import "NavigationView.h"

@interface NavigationView ()

@property (nonatomic ,strong) UIButton * leftWhiteButton;

@property (nonatomic ,strong) UIButton * rightWhiteButton;

@property (nonatomic ,strong) UIButton * leftRedButton;

@property (nonatomic ,strong) UIButton * righRedButton;

@property (nonatomic ,strong) UIView   * maskView;

@end

@implementation NavigationView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self creatSubView];
    }
    return self;
}

#pragma mark --- privte method
- (void)buttonClick:(UIButton *)button
{
    [self.delegate buttonClickWithType:button.tag];
}

- (void)setOffsetScale:(CGFloat)offsetScale
{
    _offsetScale = offsetScale;
    CGRect frame = self.maskView.frame;
    frame.origin.x = offsetScale * kWidth / 2;
    self.maskView.frame = frame;
    [self handleMaskViewOffset];
}


- (void)handleMaskViewOffset
{
    CGRect  newFrame = self.maskView.frame;
    CGFloat offsetx = newFrame.origin.x;
    self.righRedButton.alpha = offsetx / (kWidth/2);
    self.leftRedButton.alpha = (1 - offsetx / (kWidth/2));
}

#pragma mark --- create UI
- (void)creatSubView
{
    [self custom];
    self.leftWhiteButton = [self createButtonWithTitle:@"XXXX" TitleColor:kWhiteColor positonType:LeftPositon];
    self.rightWhiteButton = [self createButtonWithTitle:@"YYYY" TitleColor:kWhiteColor positonType:RightPositon];
    [self addSubview:self.maskView];
    self.leftRedButton = [self createButtonWithTitle:@"XXXX" TitleColor:kRedColor positonType:LeftPositon];
    self.righRedButton = [self createButtonWithTitle:@"YYYY" TitleColor:kRedColor positonType:RightPositon];
    self.righRedButton.alpha = 0;
}

- (UIButton *)createButtonWithTitle:(NSString *)title TitleColor:(UIColor *)titleColor positonType:(PositonType)position
{
    UIButton * button = [[UIButton alloc]initWithFrame:CGRectMake(position * kWidth/2, 0, kWidth/2, kHeight)];
    button.backgroundColor = [UIColor clearColor];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.tag = position;
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:button];
    return button;
}

- (UIView *)maskView
{
    if (!_maskView) {
        _maskView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kWidth/2, kHeight)];
        _maskView.backgroundColor = kWhiteColor;
        _maskView.layer.cornerRadius = kHeight / 2 ;
        _maskView.layer.masksToBounds = YES;
    }
    return _maskView;
}

- (void)custom
{
    self.backgroundColor = kRedColor;
    self.layer.cornerRadius = kHeight/2;
    self.layer.borderWidth = 1;
    self.layer.borderColor = kWhiteColor.CGColor;
    self.layer.masksToBounds = YES;
}

@end
