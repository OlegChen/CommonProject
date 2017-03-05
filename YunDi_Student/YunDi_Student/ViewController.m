//
//  ViewController.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/26.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "ViewController.h"

#import "BasePullTableView.h"
#import "BaseViewController.h"


#import "LoginViewController.h"
#import "RegisterViewController.h"

#import "UIView+Common.h"

#import "CustomerAlertViewManger.h"

#import "WebViewController.h"

//照片选择
#import "ImagePickerManger.h"
#import <Photos/Photos.h>


@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic ,weak) BasePullTableView * tableVeiw;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.navigationController.navigationBar.translucent = YES;
//    self.automaticallyAdjustsScrollViewInsets = false;
    
self.navigationItem.title = @"123";

    BasePullTableView *tableView = [[BasePullTableView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height - 49)];
    tableView.backgroundView.backgroundColor = [UIColor grayColor];
    [tableView config];
    [self.view addSubview:tableView];
//    tableView.haveLoadAll = YES;
//    tableView.loadMoreEnable = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    self.tableVeiw = tableView;
    
    

//加载动画
    [self.view beginLoading];
    [self.view endLoading];

    
    
    
    [CustomerAlertViewManger handleTip:nil completion:^(NSString *curTweet, BOOL sendSucess) {
        
        NSLog(@"viewlihuidiao");
        
    }];

    
    
#pragma  mark - 无数据提示 view（请求数据的回调里）
//    __weak typeof(self) weakSelf = self;
//    
//    [weakSelf.view endLoading];
//    [weakSelf.view configBlankPage:EaseBlankPageTypeView hasData:NO hasError:NO reloadButtonBlock:^(id sender) {
////        [weakSelf refreshRootFolders];
//    }];

    
    
}

- (void)viewDidAppear:(BOOL)animated{

    [super viewDidAppear:animated];
    
//    [self.tableVeiw.mj_header beginRefreshing];

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *ID = @"example";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    
    
    cell.textLabel.text = @"1231231";
    
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        
        LoginViewController * vc = [[LoginViewController alloc]init];
        
        [self.navigationController pushViewController:vc animated:YES];
        
    }else if(indexPath.row == 1){
    
//        NSString *pathForServiceterms = [[NSBundle mainBundle] pathForResource:@"service_terms" ofType:@"html"];
        WebViewController *vc = [WebViewController webVCWithUrlStr:@"http://www.baidu.com"];
        [self.navigationController pushViewController:vc animated:YES];
    
    
    }else if (indexPath.row == 2 ) {
        
        [ImagePickerManger handelImagePickerWithLimitNum:9 withController:self WithContent:^(NSArray *assets, BOOL sendSucess) {
           
            NSLog(@"图片选择回调");
            
            if (!sendSucess) {
                
                return ;
            }
            
            PHAsset *asset =  assets[0];
            
            PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
            // 是否要原图
            CGSize size ;//= original ? CGSizeMake(asset.pixelWidth, asset.pixelHeight) : CGSizeZero;

            size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);//原图
//            size = CGSizeZero;//缩略图
            
            [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
                NSLog(@"%@", result);
                
                //图片压缩
                NSData *data = UIImageJPEGRepresentation(result, 1.0);
                if ((float)data.length/1024 > 1000) {
                    data = UIImageJPEGRepresentation(result, 1024*1000.0/(float)data.length);
                }

                
                
                UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
                [self.view addSubview:imageView];
                imageView.image = result;
                
                
            }];
            
        }];
    }
    
    
    
    else{
        
        RegisterViewController * vc = [[RegisterViewController alloc]init];
    
        [self.navigationController pushViewController:vc animated:YES];
    
    }
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
