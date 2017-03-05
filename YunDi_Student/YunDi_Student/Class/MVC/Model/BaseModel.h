//
//  BaseModel.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseModel : NSObject

@property (nonatomic, assign) int result; //请求状态,失败为0,成功则为1  可用responseSuccess代替
@property (nonatomic, strong) NSString *info; //错误是返回message
@property (nonatomic, strong) NSString *message;

//- (BOOL)verifyResponseSuccess; //status = 0 时返回yes



@end
