//
//  NetWork.h
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AFNetworking.h"
#import "ApiProtocol.h"

@interface NetWork : NSObject<ApiProtocol>//,ApiIndividualProtocol,ApiUserRelatedProtocol,ApiHomeModuleProtocol,ApiChoiceAndDestinationProtocol>

@property (nonatomic,strong)NSString* tag;//请求的标识
@property (nonatomic,strong)NSString* method;//请求的方法  支持POST GET
@property (nonatomic,strong)NSDictionary* dic;//请求的参数
@property (nonatomic,strong)NSString * strUrl;//请求的地址
//在appdelegate里面调用
+ (NetWork *)shareNetwork;

//请求完成后的处理
- (AFHTTPSessionManager *)handleRequestComplectionWithDic:(NSDictionary *)dic
                                                 isNewAPI:(BOOL)newAPI
                                                      Tag:(NSString *)tag
                                                ClassName:(NSString *)classname
                                            WaitAnimation:(BOOL)stop
                                               Completion:(RequestSuccessBlock)succession
                                                    Error:(RequestfaildBlock)failed;

//请求完成后的处理
- (AFHTTPSessionManager *)handleDefaultRequestComplectionWithDic:(NSDictionary *)dic
                                                        isNewAPI:(BOOL)newAPI
                                                             Tag:(NSString *)tag
                                                       ClassName:(NSString *)classname
                                                   WaitAnimation:(BOOL)stop
                                                      Completion:(RequestSuccessBlock)succession
                                                           Error:(RequestfaildBlock)failed;

//上传图片完成后的处理
- (AFHTTPSessionManager *)handleFormDataComplectionWithDic:(NSDictionary *)dic
                                                  isNewAPI:(BOOL)newAPI
                                                       Tag:(NSString *)tag
                                                  CustomID:(id)customId
                                                 ClassName:(NSString *)classname
                                             WaitAnimation:(BOOL)stop
                                                Completion:(RequestSuccessBlock)succession
                                                     Error:(RequestfaildBlock)failed;

+ (void)cancelRequsting;

@end
