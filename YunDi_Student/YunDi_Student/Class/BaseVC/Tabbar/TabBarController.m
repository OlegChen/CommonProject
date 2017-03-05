

#import "TabBarController.h"
#import "BarButton.h"
#import "Navigation.h"
#import "ViewController.h"

#import "XMGTabBar.h"
#import "UIImage+Image.h"

#import "MeViewController.h"

#import "UIImage+Common.h"


@interface TabBarController ()


@end

@implementation TabBarController

//- (void)viewDidLoad {
//    [super viewDidLoad];
////    [SXAdManager loadLatestAdImage];
////    if ([SXAdManager isShouldDisplayAd]) {
////        // ------这里主要是容错一个bug。
////        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"top20"];
////        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"rightItem"];
////        
////        
////        // ------本想吧广告设置成广告显示完毕之后再加载rootViewController的，但是由于前期已经使用storyboard搭建了，写在AppDelete里会冲突，只好就随便整个view广告
////        UIView *adView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
////        UIImageView *adImg = [[UIImageView alloc]initWithImage:[SXAdManager getAdImage]];
////        UIImageView *adBottomImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"adBottom.png"]];
////        [adView addSubview:adBottomImg];
////        [adView addSubview:adImg];
////        adBottomImg.frame = CGRectMake(0, self.view.height - 135, self.view.width, 135);
////        adImg.frame = CGRectMake(0, 0, self.view.width, self.view.height - 135);
////        
//////        adImg.frame = [UIScreen mainScreen].bounds;
////        adView.alpha = 0.99f;
////        [self.view addSubview:adView];
////        [[UIApplication sharedApplication]setStatusBarHidden:YES];
////        
////        [UIView animateWithDuration:3 animations:^{
////            adView.alpha = 1.0f;
////        } completion:^(BOOL finished) {
////            [[UIApplication sharedApplication]setStatusBarHidden:NO];
////            [UIView animateWithDuration:0.5 animations:^{
////                adView.alpha = 0.0f;
////            } completion:^(BOOL finished) {
////                [adView removeFromSuperview];
////            }];
////            [[NSNotificationCenter defaultCenter]postNotificationName:@"SXAdvertisementKey" object:nil];
////        }];
////    }else{
////        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"update"];
////    }
//    
//    
//    
//
//    
//    TabBar *tabBar = [[TabBar alloc]init];
//    tabBar.frame = self.tabBar.frame;
//    tabBar.backgroundColor = [UIColor colorWithRed:239/255.0 green:239/255.0 blue:239/255.0 alpha:1];
//    
//    
//    [self.tabBar addSubview:tabBar];
//    
//    
//    tabBar.delegate = self;
//    
//    
//    [tabBar addImageView];
//    
//    [tabBar addBarButtonWithNorName:@"arrow.png" andDisName:@"arrow.png" andTitle:@"新闻"];
//    [tabBar addBarButtonWithNorName:@"arrow" andDisName:@"tabbar_icon_reader_highlight" andTitle:@"阅读"];
//    [tabBar addBarButtonWithNorName:@"arrow" andDisName:@"tabbar_icon_media_highlight" andTitle:@"视听"];
//    [tabBar addBarButtonWithNorName:@"arrow" andDisName:@"tabbar_icon_found_highlight" andTitle:@"发现"];
//    [tabBar addBarButtonWithNorName:@"arrow" andDisName:@"tabbar_icon_me_highlight" andTitle:@"我"];
//    
//    self.selectedIndex = 0;
//    
//    
//    [self setupAllChildViewController];
//
//}
//
//#pragma mark - 添加所有子控制器
//- (void)setupAllChildViewController
//{
//    // 精华
//    ViewController *essenceVc = [[ViewController alloc] init];
//    Navigation *nav = [[Navigation alloc] initWithRootViewController:essenceVc];
////    nav.title  = @"1111";
//    // initWithRootViewController:push
//    [self addChildViewController:nav];
//    
//    // 精华
//    ViewController *essenceVc1 = [[ViewController alloc] init];
//    Navigation *nav1 = [[Navigation alloc] initWithRootViewController:essenceVc1];
//    // initWithRootViewController:push
//    [self addChildViewController:nav1];
//    
//    // 精华
//    ViewController *essenceVc2 = [[ViewController alloc] init];
//    Navigation *nav2 = [[Navigation alloc] initWithRootViewController:essenceVc2];
//    // initWithRootViewController:push
//    [self addChildViewController:nav2];
//    
//    // 精华
//    ViewController *essenceVc3 = [[ViewController alloc] init];
//    Navigation *nav3 = [[Navigation alloc] initWithRootViewController:essenceVc3];
//    // initWithRootViewController:push
//    [self addChildViewController:nav3];
//    
//    // 精华
//    ViewController *essenceVc4 = [[ViewController alloc] init];
//    Navigation *nav4 = [[Navigation alloc] initWithRootViewController:essenceVc4];
//    // initWithRootViewController:push
//    [self addChildViewController:nav4];
//    
//
//}
//
//
//
//#pragma mark - ******************** SXTabBarDelegate代理方法
//- (void)ChangSelIndexForm:(NSInteger)from to:(NSInteger)to
//{
//    self.selectedIndex = to;
//}
//

// 只会调用一次
+ (void)load
{
    // 获取哪个类中UITabBarItem
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    
    // 设置按钮选中标题的颜色:富文本:描述一个文字颜色,字体,阴影,空心,图文混排
    // 创建一个描述文本属性的字典
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = [UIColor blackColor];
    [item setTitleTextAttributes:attrs forState:UIControlStateSelected];
    
    // 设置字体尺寸:只有设置正常状态下,才会有效果
    NSMutableDictionary *attrsNor = [NSMutableDictionary dictionary];
    attrsNor[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    [item setTitleTextAttributes:attrsNor forState:UIControlStateNormal];
    
}

#pragma mark - 生命周期方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    // 1 添加子控制器(5个子控制器) -> 自定义控制器 -> 划分项目文件结构
    [self setupAllChildViewController];
    
    // 2 设置tabBar上按钮内容 -> 由对应的子控制器的tabBarItem属性
    [self setupAllTitleButton];
    
    // 3.自定义tabBar
    [self setupTabBar];
    
    }

#pragma mark - 自定义tabBar
- (void)setupTabBar
{
    XMGTabBar *tabBar = [[XMGTabBar alloc] init];
    [self setValue:tabBar forKey:@"tabBar"];
    
    //修改背景颜色 （还可以加view）
    [[UITabBar appearance] setBackgroundImage:[UIImage imageWithColor:[UIColor redColor]]];
    
    
    [UITabBar appearance].translucent = NO;
    
    
    
    
}

/*
 Changing the delegate of a tab bar 【managed by a tab bar controller】 is not allowed.
 被UITabBarController所管理的UITabBar的delegate是不允许修改的
 */

#pragma mark - 添加所有子控制器
- (void)setupAllChildViewController
{
    // 精华
    ViewController *essenceVc = [[ViewController alloc] init];
    Navigation *nav = [[Navigation alloc] initWithRootViewController:essenceVc];
    // initWithRootViewController:push
    [self addChildViewController:nav];
    
    // 新帖
    ViewController *newVc = [[ViewController alloc] init];
    Navigation *nav1 = [[Navigation alloc] initWithRootViewController:newVc];
    [self addChildViewController:nav1];
    
    // 关注
    ViewController *ftVc = [[ViewController alloc] init];
    Navigation *nav3 = [[Navigation alloc] initWithRootViewController:ftVc];
    [self addChildViewController:nav3];
    
    // 我
    MeViewController *meVc = [[MeViewController alloc] init];
    meVc.isRoot = YES;
    Navigation *nav4 = [[Navigation alloc] initWithRootViewController:meVc];
    [self addChildViewController:nav4];
}

// 设置tabBar上所有按钮内容
- (void)setupAllTitleButton
{
    // 0:nav
    UINavigationController *nav = self.childViewControllers[0];
    nav.tabBarItem.title = @"精华";
    nav.tabBarItem.image = [UIImage imageNamed:@"tabBar_essence_icon"];
    // 快速生成一个没有渲染图片
    nav.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_essence_click_icon"];
    
    // 1:新帖
    UINavigationController *nav1 = self.childViewControllers[1];
    nav1.tabBarItem.title = @"新帖";
    nav1.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    nav1.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_new_click_icon"];
    
    // 3.关注
    UINavigationController *nav3 = self.childViewControllers[2];
    nav3.tabBarItem.title = @"关注";
    nav3.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    nav3.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_friendTrends_click_icon"];
    
    
    
    // 4.我
    UINavigationController *nav4 = self.childViewControllers[3];
    nav4.tabBarItem.title = @"我";
    nav4.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    nav4.tabBarItem.selectedImage = [UIImage imageOriginalWithName:@"tabBar_me_click_icon"];
}


@end
