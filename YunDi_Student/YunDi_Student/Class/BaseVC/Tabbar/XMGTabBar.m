//
//  XMGTabBar.m
//  BuDeJie
//
//  Created by xiaomage on 16/3/12.
//  Copyright © 2016年 小码哥. All rights reserved.
//

#import "XMGTabBar.h"
#import "UIView+FP.h"
@interface XMGTabBar ()

@property (nonatomic, weak) UIButton *plusButton;

/** 上一次点击的按钮 */ 
@property (nonatomic, weak) UIControl *previousClickedTabBarButton;
@end

@implementation XMGTabBar

- (UIButton *)plusButton
{
    if (_plusButton == nil) {
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_icon"] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"tabBar_publish_click_icon"] forState:UIControlStateHighlighted];
        [btn sizeToFit];
        [self addSubview:btn];
        
        _plusButton = btn;
    }
    return _plusButton;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // 跳转tabBarButton位置
    NSInteger count = self.items.count;
    
    CGFloat btnW = self.width / (count); //中间加入按钮的话 （count + 1）
    CGFloat btnH = self.height;
    CGFloat x = 0;
    int i = 0;
    // 私有类:打印出来有个类,但是敲出来没有,说明这个类是系统私有类
    // 遍历子控件 调整布局
    for (UIControl *tabBarButton in self.subviews) {

        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            // 设置previousClickedTabBarButton默认值为最前面的按钮
            if (i == 0 && self.previousClickedTabBarButton == nil) {
                self.previousClickedTabBarButton = tabBarButton;
            }
            
//            if (i == 2) {
//                i += 1;
//            }
            
            x = i * btnW;
            
            tabBarButton.frame = CGRectMake(x, 0, btnW, btnH);
            
            i++;
            
            // UIControlEventTouchDownRepeat : 在短时间内连续点击按钮
            
            // 监听点击
            [tabBarButton addTarget:self action:@selector(tabBarButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    // 调整发布按钮位置
//    self.plusButton.center = CGPointMake(self.width * 0.5, self.height * 0.5);
    
}

/**
 *  tabBarButton的点击
 */
- (void)tabBarButtonClick:(UIControl *)tabBarButton
{
    if (self.previousClickedTabBarButton == tabBarButton) {
        // 发出通知，告知外界tabBarButton被重复点击了
        [[NSNotificationCenter defaultCenter] postNotificationName:@"" object:nil];
    }
    
    self.previousClickedTabBarButton = tabBarButton;
}

@end
