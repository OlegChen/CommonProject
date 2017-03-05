//
//  BaseModel.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel

- (NSString *)message
{
    //    [ErrorMsgObject sharedInstance];
    //    if (![ErrorMsgObject message:_result]) {
    //        return _message;
    //    }
    //    return [ErrorMsgObject message:_result];
    if (!_info||[_info isEqualToString:@""]) {
        return _message;
    }
    return _info;
}

@end
