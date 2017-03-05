//
//  BasePullTableView.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/26.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "BasePullTableView.h"

#import "CustomerRefreshHeader.h"

@implementation BasePullTableView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    
    if (self) {
        
//        [self config];
    }

    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
         [self config];
    }
    return self;
}



- (void)setLoadMoreEnable:(BOOL)loadMoreEnable
{
    _loadMoreEnable = loadMoreEnable;
    if (_loadMoreEnable)
    {
        self.mj_footer.hidden = NO;
        self.mj_header.hidden = NO;

    }
    else
    {
        self.mj_header.hidden = YES;
        self.mj_footer.hidden = YES;
    }
}

- (void)setHaveLoadAll:(BOOL)haveLoadAll
{
//    self.haveLoadAll = haveLoadAll;
    
    [self.mj_footer endRefreshingWithNoMoreData];
}

- (void)config
{
    //    delegateInterceptor = [[MessageInterceptor alloc] init];
    //    delegateInterceptor.middleMan = self;
    //    delegateInterceptor.receiver = self.delegate;
    //    super.delegate = (id)delegateInterceptor;
    
    // 防止block循环retain，所以用__unsafe_unretained
    

    self.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    //下拉刷新
    self.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewRefresh)];

//    [self.mj_header beginRefreshing];

    
#pragma mark - 自定义动画 刷新
//    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadNewData方法）
//    CustomerRefreshHeader *header = [CustomerRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(tableViewRefresh)];
//    // 隐藏时间
//    header.lastUpdatedTimeLabel.hidden = YES;
//    // 隐藏状态
//    header.stateLabel.hidden = YES;
//    // 设置header
//    self.mj_header = header;
    
    // 立即刷新
//    [self.mj_header beginRefreshing];

//    self.pagingEnabled = false;
    // 上拉加载更多控
//    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewLoadMore)];
    
    
    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    self.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(tableViewLoadMore)];
    // 无数据隐藏
    self.mj_footer.automaticallyHidden = YES;


    
}

//- (void)configWithoutFooter
//{
//    [_footer removeFromSuperview];
//    _footer.delegate = nil;
//    _footer.scrollView = nil;
//    _footer = nil;
//}
//
//- (void)configWithoutHeader
//{
//    [self.headerView removeFromSuperview];
//    self.headerView = nil;
//    _header.delegate = nil;
//    _header.scrollView = nil;
//    _header = nil;
//}

//- (void)setRealEdgeInsets:(UIEdgeInsets)realEdgeInsets
//{
//    _header.realEdgeInsets = realEdgeInsets;
//    _footer.realEdgeInsets = realEdgeInsets;
//}

#pragma mark - Preserving the original behaviour

- (void)reloadData
{
    [super reloadData];
    // Give the footers a chance to fix it self.
    if (self.mj_header.isRefreshing)
        [self.mj_header endRefreshing];
    if (self.mj_footer.isRefreshing)
        [self.mj_footer endRefreshing];
}

//- (id)initWithFrame:(CGRect)frame
//{
//    self = [super initWithFrame:frame];
//    if (self) {
//        // Initialization code
//        [self config];
//    }
//    return self;
//}

- (void)awakeFromNib
{
    [super awakeFromNib];
//    [self config];
}


#pragma mark - 上拉下拉刷新 


- (void)tableViewRefresh{

    if ([_pullDelegate respondsToSelector:@selector(pullTableViewDidTriggerRefresh:)])
        [_pullDelegate pullTableViewDidTriggerRefresh:self];

    
    [self.mj_footer resetNoMoreData];

}

- (void)tableViewLoadMore{

    if ([_pullDelegate respondsToSelector:@selector(pullTableViewDidTriggerLoadMore:)])
        [_pullDelegate pullTableViewDidTriggerLoadMore:self];

    
    
}

@end
