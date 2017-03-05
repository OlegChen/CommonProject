//
//  ApiIndividualProtocol.h
//  GeneralStructure
//
//  Created by Elroy on 14/6/17.
//  Copyright (c) 2014年 Elroy. All rights reserved.
//


#import "ApiProtocol.h"

@protocol ApiIndividualProtocol <NSObject>

@optional
/*-----------------------------------登陆 注册 个人信息 相关 1～ ----------------------------------*/

/**
 *	@brief	!!!:1 注册
 *
 *  @since
 *
 *	@param 	Loginname   手机号或邮箱
 *	@param 	type        1手机号 2邮箱
 *	@param  nickname    昵称
 *	@param  password    密码
 */
+ (AFHTTPSessionManager *)RegisterLoginName:(NSString *)name
                                                Type:(int)type
                                            nickName:(NSString *)nickname
                                            password:(NSString *)password
                                              Images:(NSArray *)arrImages
                                       WaitAnimation:(BOOL)stop
                              CompletionHandler:(RequestSuccessBlock)succession
                                   errorHandler:(RequestfaildBlock)failed;

/**
 *	@brief	!!!:2 登录
 *
 *  @since
 *
 *	@param 	Phone       手机号
 *	@param  password    密码
 */



@end