//
//  BasePullTableView.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/26.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MJRefresh.h"


@class BasePullTableView;

@protocol PullTableViewDelegate <NSObject>

@optional
- (void)pullTableViewDidTriggerRefresh:(BasePullTableView *)pullTableView;
- (void)pullTableViewDidTriggerLoadMore:(BasePullTableView *)pullTableView;

@end

@interface BasePullTableView : UITableView{
//    MJRefreshHeaderView *_header;
    MJRefreshHeader *_footer;
    //    MessageInterceptor * delegateInterceptor;
    
}


//
//@property (nonatomic, weak) UIView *headerView;
@property (nonatomic, weak) UIView *footerView;

@property (nonatomic) UIEdgeInsets realEdgeInsets;
@property (nonatomic, getter = isLoadMoreEnable) BOOL loadMoreEnable;

@property (nonatomic,assign) BOOL haveLoadAll;
/* Delegate */
@property (nonatomic, assign) IBOutlet id<PullTableViewDelegate> pullDelegate;

- (void)config;

//- (void)configWithoutHeader;
//- (void)configWithoutFooter;

@end
