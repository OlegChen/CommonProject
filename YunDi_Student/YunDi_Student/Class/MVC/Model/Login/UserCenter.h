//
//  UserCenter.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/29.
//  Copyright © 2016年 Chen. All rights reserved.
//
#import "UserModel.h"
#import <UIKit/UIKit.h>

@interface UserCenter : NSObject

+ (void)doLogin:(NSDictionary *)loginData;

+ (void) doLogout;

+ (UserModel *)curLoginUser;

//是否登录了
+ (BOOL) isLogin;

@end
