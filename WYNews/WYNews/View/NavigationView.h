//
//  NavigationView.h
//  WYNews
//
//  Created by LiQuan on 16/5/13.
//  Copyright © 2016年 LiQuan. All rights reserved.
//

#import <UIKit/UIKit.h>
#define kRedColor     [UIColor redColor]
#define kWhiteColor   [UIColor whiteColor]
#define kClearColor   [UIColor clearColor]

typedef NS_ENUM(NSInteger,PositonType) {
    LeftPositon ,
    RightPositon
};

@protocol NavigationViewDelegate <NSObject>

@optional
- (void)buttonClickWithType:(PositonType)actionType;

@end

@interface NavigationView : UIView

@property (nonatomic ,assign) CGFloat offsetScale; //遮挡视图的偏移比例

@property (nonatomic ,weak) id<NavigationViewDelegate>delegate;

@end
