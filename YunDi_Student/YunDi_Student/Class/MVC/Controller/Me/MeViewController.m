//
//  MeViewController.m
//  FengYunDi_Student
//
//  Created by Chen on 16/8/3.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "MeViewController.h"

#import "BasePullTableView.h"
#import "UserInfoIconCell.h"
#import "UserInfoTextCell.h"

@interface MeViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) BasePullTableView *myTableView;


@end

@implementation MeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    if (_isRoot) {
        self.title = @"我";
//        _curUser = [Login curLoginUser]? [Login curLoginUser]: [User userWithGlobalKey:@""];
        
        [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"settingBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(settingBtnClicked:)] animated:NO];
        [self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"addUserBtn_Nav"] style:UIBarButtonItemStylePlain target:self action:@selector(addUserBtnClicked:)] animated:NO];
        
    }else{
        self.title = @"他人主页"; //_curUser.name;
    }
    
    //    添加myTableView
    _myTableView = ({
        BasePullTableView *tableView = [[BasePullTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
        tableView.dataSource = self;
        tableView.delegate = self;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [tableView registerClass:[UserInfoTextCell class] forCellReuseIdentifier:kCellIdentifier_UserInfoTextCell];
        [tableView registerClass:[UserInfoIconCell class] forCellReuseIdentifier:kCellIdentifier_UserInfoIconCell];
        [self.view addSubview:tableView];
        [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
        }];
        if (_isRoot) {
            UIEdgeInsets insets = UIEdgeInsetsMake(0, 0, 49, 0);
            tableView.contentInset = insets;
            tableView.scrollIndicatorInsets = insets;
        }
        tableView;
    });
    __weak typeof(self) weakSelf = self;
//    _headerView = [EaseUserHeaderView userHeaderViewWithUser:_curUser image:[StartImagesManager shareManager].curImage.image];
//    _headerView.userIconClicked = ^(){
//        [weakSelf userIconClicked];
//    };
//    _headerView.fansCountBtnClicked = ^(){
//        [weakSelf fansCountBtnClicked];
//    };
//    _headerView.followsCountBtnClicked = ^(){
//        [weakSelf followsCountBtnClicked];
//    };
//    _headerView.followBtnClicked = ^(){
//        [weakSelf followBtnClicked];
//    };
//    [_myTableView addParallaxWithView:_headerView andHeight:CGRectGetHeight(_headerView.frame)];
    if (![self isMe]) {
        _myTableView.tableFooterView = [self footerV];
    }
    
//    _refreshControl = [[ODRefreshControl alloc] initInScrollView:self.myTableView];
//    [_refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
}

- (BOOL)isMe{
//    return (_isRoot || [_curUser.global_key isEqualToString:[Login curLoginUser].global_key]);
    
    return _isRoot;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self refresh];
}

- (void)dealloc
{
    _myTableView.delegate = nil;
    _myTableView.dataSource = nil;
}


- (void)refresh{
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_UserInfo_WithObj:_curUser andBlock:^(id data, NSError *error) {
//        [weakSelf.refreshControl endRefreshing];
//        if (data) {
//            weakSelf.curUser = data;
//            weakSelf.headerView.curUser = data;
//            weakSelf.title = _isRoot? @"我": weakSelf.curUser.name;
//            [weakSelf.myTableView reloadData];
//        }
//    }];
}

#pragma mark footerV
- (UIView *)footerV{
    UIView *footerV = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 72)];
    
//    
//    UIButton *footerBtn = [[UIButton alloc]initWithFrame:CGRectMake(PaddingLeftWidth, (CGRectGetHeight(footerV.frame)-44)/2 , SCREEN_WIDTH - 2*PaddingLeftWidth, 44)];
//    
//    [footerBtn setTitle:@"发消息" forState:UIControlStateNormal];
//    [footerBtn addTarget:self action:@selector(footerBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    
//    [footerV addSubview:footerBtn];
    return footerV;
}

#pragma mark Table M
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    return [self.curUser.global_key isEqualToString:[Login curLoginUser].global_key]? 4: 3;
    
    //需根据自己还是他人主页判断 判断
    
    return 3;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger row = 0;
    if (section == 0) {
        row = [self isMe]? 0: 3;
    }else if (section == 1){
        row = 1;
    }else if (section == 2){
        row = [self isMe]? 4: 3;
    }else if (section == 3){
        row = 1;
    }
    return row;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        UserInfoTextCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_UserInfoTextCell forIndexPath:indexPath];
        switch (indexPath.row) {
//            case 0:
//                [cell setTitle:@"所在地" value:_curUser.location];
//                break;
//            case 1:
//                [cell setTitle:@"座右铭" value:_curUser.slogan];
//                break;
//            default:
//                [cell setTitle:@"个性标签" value:_curUser.tags_str];
//                break;
                
           
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:PaddingLeftWidth];
        return cell;
    }else{
        UserInfoIconCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_UserInfoIconCell forIndexPath:indexPath];
        if (indexPath.section == 1) {
            [cell setTitle:@"详细信息" icon:@"user_info_detail"];
        }else if (indexPath.section == 2){
            if (indexPath.row == 0) {
                [cell setTitle:[self isMe]? @"我的项目": @"Ta的项目" icon:@"user_info_project"];
            }else if(indexPath.row == 1){
                [cell setTitle:[self isMe]? @"我的冒泡": @"Ta的冒泡" icon:@"user_info_tweet"];
            }else if (indexPath.row == 2){
                [cell setTitle:[self isMe]? @"我的话题": @"Ta的话题" icon:@"user_info_topic"];
            }else{
                [cell setTitle:@"本地文件" icon:@"user_info_file"];
            }
        }else{
            [cell setTitle:@"我的码币" icon:@"user_info_point"];
            
            //提示数字
//            if ([[FunctionTipsManager shareManager] needToTip:kFunctionTipStr_Me_Points]) {
//                [cell addTipIcon];
//            }
        }
        [tableView addLineforPlainCell:cell forRowAtIndexPath:indexPath withLeftSpace:PaddingLeftWidth];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    CGFloat cellHeight = 0;
    if (indexPath.section == 0) {
        cellHeight = [UserInfoTextCell cellHeight];
    }else{
        cellHeight = [UserInfoIconCell cellHeight];
    }
    return cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (![self isMe]
        && section == [self numberOfSectionsInTableView:self.myTableView] -1) {
        return 0.5;
    }
    return 20.0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.5;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 20)];
    footerView.backgroundColor = [UIColor lightGrayColor];
    return footerView;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 1) {
        [self goToDetailInfo];
    }else if (indexPath.section == 2){
        if (indexPath.row == 0) {
            [self goToProjects];
        }else if(indexPath.row == 1){
            [self goToTweets];
        }else if (indexPath.row == 2){
            [self goToTopic];
        }else{
            [self goToLocalFolders];
        }
    }else if (indexPath.section == 3){
//        if ([[FunctionTipsManager shareManager] needToTip:kFunctionTipStr_Me_Points]) {
//            [[FunctionTipsManager shareManager] markTiped:kFunctionTipStr_Me_Points];
//            UserInfoIconCell *cell = (UserInfoIconCell *)[tableView cellForRowAtIndexPath:indexPath];
//            [cell removeTip];
//        }
        [self goToPoint];
    }
}

#pragma mark Btn Clicked
- (void)fansCountBtnClicked{
    
}
- (void)followsCountBtnClicked{
    
}

- (void)userIconClicked{
//    //        显示大图
//    MJPhoto *photo = [[MJPhoto alloc] init];
//    photo.url = [_curUser.avatar urlWithCodePath];
//    
//    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
//    browser.currentPhotoIndex = 0;
//    browser.photos = [NSArray arrayWithObject:photo];
//    [browser show];
}

- (void)messageBtnClicked{
//    ConversationViewController *vc = [[ConversationViewController alloc] init];
//    vc.myPriMsgs = [PrivateMessages priMsgsWithUser:_curUser];
//    [self.navigationController pushViewController:vc animated:YES];
}
- (void)followBtnClicked{
//    __weak typeof(self) weakSelf = self;
//    [[Coding_NetAPIManager sharedManager] request_FollowedOrNot_WithObj:_curUser andBlock:^(id data, NSError *error) {
//        if (data) {
//            weakSelf.curUser.followed = [NSNumber numberWithBool:!_curUser.followed.boolValue];
//            weakSelf.headerView.curUser = weakSelf.curUser;
//            if (weakSelf.followChanged) {
//                weakSelf.followChanged(weakSelf.curUser);
//            }
//        }
//    }];
}

- (void)goToTweets{
//    UserOrProjectTweetsViewController *vc = [[UserOrProjectTweetsViewController alloc] init];
//    vc.curTweets = [Tweets tweetsWithUser:_curUser];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToTopic {
//    CSMyTopicVC *vc = [[CSMyTopicVC alloc] init];
//    vc.curUser = _curUser;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToLocalFolders{
//    LocalFoldersViewController *vc = [LocalFoldersViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToPoint{
//    PointRecordsViewController *vc = [PointRecordsViewController new];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark Nav
- (void)settingBtnClicked:(id)sender{
//    SettingViewController *vc = [[SettingViewController alloc] init];
//    vc.myUser = self.curUser;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)addUserBtnClicked:(id)sender{
//    AddUserViewController *vc = [[AddUserViewController alloc] init];
//    vc.type = AddUserTypeFollow;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToProjects{
//    ProjectListViewController *vc = [[ProjectListViewController alloc] init];
//    vc.curUser = _curUser;
//    [self.navigationController pushViewController:vc animated:YES];
}

- (void)goToDetailInfo{
//    if ([self isMe]) {
//        SettingMineInfoViewController *vc = [[SettingMineInfoViewController alloc] init];
//        [self.navigationController pushViewController:vc animated:YES];
//    }else{
//        UserInfoDetailViewController *vc = [[UserInfoDetailViewController alloc] init];
//        vc.curUser = self.curUser;
//        [self.navigationController pushViewController:vc animated:YES];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
