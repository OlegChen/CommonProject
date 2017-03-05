//
//  UserCenter.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/29.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "UserCenter.h"


#define LoginStatus @"login_status"
#define kLoginPreUserEmail @"pre_user_email"
#define LoginUserDict @"user_dict"
#define kLoginDataListPath @"login_data_list_path.plist"

static UserModel *curLoginUser;



@interface UserCenter ()

@end

@implementation UserCenter

+ (void)doLogin:(NSDictionary *)loginData{
    
    //    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
    //    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
    //        NSLog(@"cookies : %@", obj.description);
    //    }];
    
    if (loginData) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setObject:[NSNumber numberWithBool:YES] forKey:LoginStatus];
        [defaults setObject:loginData forKey:LoginUserDict];
        
//        curLoginUser = [NSObject objectOfClass:@"User" fromJSON:loginData];  转模型
        
        [defaults synchronize];
        
#pragma mark - 加 推送设置
        
        [self saveLoginData:loginData];
    }else{
        
        
        [UserCenter doLogout];
    }
}

+ (NSMutableDictionary *)readLoginDataList{
    NSMutableDictionary *loginDataList = [NSMutableDictionary dictionaryWithContentsOfFile:[self loginDataListPath]];
    if (!loginDataList) {
        loginDataList = [NSMutableDictionary dictionary];
    }
    return loginDataList;
}

//user list
+ (BOOL)saveLoginData:(NSDictionary *)loginData{
    BOOL saved = NO;
    if (loginData) {
        NSMutableDictionary *loginDataList = [self readLoginDataList];
      
#pragma mark - 要存的数据
    /* 要存的数据
        User *curUser = [NSObject objectOfClass:@"User" fromJSON:loginData];
        if (curUser.global_key.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.global_key];
            saved = YES;
        }
        if (curUser.email.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.email];
            saved = YES;
        }
        if (curUser.phone.length > 0) {
            [loginDataList setObject:loginData forKey:curUser.phone];
            saved = YES;
        }
        */
        
        if (saved) {
            saved = [loginDataList writeToFile:[self loginDataListPath] atomically:YES];
        }
    }
    return saved;
}

+ (NSString *)loginDataListPath{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    return [documentPath stringByAppendingPathComponent:kLoginDataListPath];
}


+ (void)doLogout{
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:[NSNumber numberWithBool:NO] forKey:LoginStatus];
    [defaults synchronize];
    //删掉 coding 的 cookie
//    NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies];
//    [cookies enumerateObjectsUsingBlock:^(NSHTTPCookie *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        if ([obj.domain hasSuffix:@".coding.net"]) {
//            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:obj];
//        }
//    }];
    
#pragma mark - 解除推送绑定
    
    
}


+ (UserModel *)curLoginUser{
    if (!curLoginUser) {
        NSDictionary *loginData = [[NSUserDefaults standardUserDefaults] objectForKey:LoginUserDict];
//        curLoginUser = loginData? [NSObject objectOfClass:@"User" fromJSON:loginData]: nil;
        
#pragma mark - 数据处理 ====
        
        
    }
    return curLoginUser;
}

+ (BOOL) isLogin{

#pragma mark - ddddd

    return NO;
}



@end
