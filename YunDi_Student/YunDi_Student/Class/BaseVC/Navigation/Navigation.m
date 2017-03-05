//
//  Navigation.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/27.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "Navigation.h"
#import "UIBarButtonItem+Item.h"

@implementation Navigation

+ (void)initialize
{
    // 设置导航栏的主题
//    UINavigationBar *navBar = [UINavigationBar appearance];
//    [navBar setBarTintColor:[UIColor redColor]];
    
    [self setupItemTheme];
    
    [self setupNavTheme];
}

+ (void)setupNavTheme
{
    
    // 1.拿到导航条的主题对象
    UINavigationBar *navBar = [UINavigationBar appearance];
    
    //    [navBar setBackgroundImage:[UIImage imageNamed:@"navBarBG"] forBarMetrics:UIBarMetricsDefault];
    
    //深颜色
    //    [navBar setBackgroundImage:[UIImage resizableImageWithName:@"navBarBG"]forBarMetrics:UIBarMetricsDefault];
    
    [navBar setBarTintColor:[UIColor redColor]];

    navBar.tintColor = [UIColor whiteColor];
    
//    [navBar setBackgroundImage:[UIImage imageWithColor:COMMON_COLOR] forBarMetrics:0];
    
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
        
        navBar.translucent = NO;
        
    }
    
    
    //navBar.alpha=1.0;
    
    // 4.设置标题的属性
    NSMutableDictionary *md = [NSMutableDictionary dictionary];
    
  
    md[NSFontAttributeName] = [UIFont fontWithName:@"Arial" size:20];
    md[NSForegroundColorAttributeName] = [UIColor whiteColor];
    [navBar setTitleTextAttributes:md];
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) { // 非根控制器
        
        // 恢复滑动返回功能 -> 分析:把系统的返回按钮覆盖 -> 1.手势失效(1.手势被清空 2.可能手势代理做了一些事情,导致手势失效)
        viewController.hidesBottomBarWhenPushed = YES;
        
        // 设置返回按钮
        viewController.navigationItem.leftBarButtonItem = [UIBarButtonItem backItemWithimage:[UIImage imageNamed:@"arrow.png"] highImage:[UIImage imageNamed:@"arrow"]  target:self action:@selector(popView) title:@"返回"];
    }
    
    // 真正在跳转
    [super pushViewController:viewController animated:animated];
}


+ (void)setupItemTheme
{
    
    UIBarButtonItem *barItem = [UIBarButtonItem appearance];
    
    
    // 2.1设置文本属性
    // 2.1.1默认状态
    NSMutableDictionary *norMd = [NSMutableDictionary dictionary];
    norMd[NSForegroundColorAttributeName] = [UIColor whiteColor];
    norMd[NSFontAttributeName] = [UIFont systemFontOfSize:20];
    
    NSShadow *shadow = [[NSShadow alloc] init];
    shadow.shadowOffset = CGSizeZero;
    norMd[NSShadowAttributeName] = shadow;
    [barItem setTitleTextAttributes:norMd forState:UIControlStateNormal];
    
    // 2.1.1高亮状态
    NSMutableDictionary *higMd = [NSMutableDictionary  dictionaryWithDictionary:norMd];
    higMd[NSForegroundColorAttributeName] = [UIColor redColor];
    [barItem setTitleTextAttributes:higMd forState:UIControlStateHighlighted];
    
    // 2.2设置不可用状态
    NSMutableDictionary *disMd = [NSMutableDictionary  dictionaryWithDictionary:norMd];
    disMd[NSForegroundColorAttributeName] = [UIColor lightGrayColor];
    [barItem setTitleTextAttributes:disMd forState:UIControlStateDisabled];
    
    //    if (!iOS7) {
    //        // 3.设置按钮的背景图片
    //        [barItem setBackgroundImage:[UIImage imageWithNmae:@"navigationbar_button_background"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    //    }
}

- (void)popView
{
    // 回到上一级界面
    [self popViewControllerAnimated:YES];
}


@end
