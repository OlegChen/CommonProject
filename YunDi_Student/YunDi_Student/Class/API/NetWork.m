//
//  NetWork.m
//  FengYunDi_Student
//
//  Created by Chen on 16/7/28.
//  Copyright © 2016年 Chen. All rights reserved.
//

#import "NetWork.h"

@interface NetWork ()

@property (strong, nonatomic) NSMutableDictionary * muDicRequest;

@end

@implementation NetWork

static NetWork *sharedObj = nil;//第一步：静态实例，并初始化。

+ (NetWork *)shareNetwork
{
    @synchronized (self)
    {
        if (sharedObj == nil)
        {
            sharedObj = [[self alloc] init];
        }
    }
    return sharedObj;
}

- (id)init
{
    if (self = [super init]) {
        _muDicRequest = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)isRequseting
{
    return _muDicRequest&&[_muDicRequest.allKeys count];
}


//网络请求
- (AFHTTPSessionManager *)requestWithDic:(NSDictionary *)dic
                                isNewAPI:(BOOL)newAPI
                                  AndTag:(NSString *)tag
                                 success:(void (^)(AFHTTPSessionManager *operation,id Object))success
                                 failure:(void (^)(AFHTTPSessionManager *operation, NSError *error))failure
{
    
//    NSString *baseURL = newAPI ? DefaultServerAddress2 : DefaultServerAddress;
    NSString *requestUrl = @"";//[NSString stringWithFormat:@"%@/%@",baseURL,DefaultServerCommonASPX];
    requestUrl = [requestUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    [dict setObject:tag forKey:@"requestCommand"];

    NSLog(@"\n🔷requestUrl = %@",requestUrl);
    NSLog(@"\n🔷params = %@",dict);
    
    
    AFHTTPSessionManager *operationManager = [AFHTTPSessionManager manager];
    
    //根据传入参数生成请求
    operationManager.requestSerializer = [AFJSONRequestSerializer serializer];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [operationManager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    operationManager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"application/json"];
    
    [operationManager POST:requestUrl parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSString *responseString = [NSString stringWithFormat:@"%@",responseObject];
        NSString *responseUTFNonLossyASCIIStringEncoding = [NSString stringWithCString:[responseString cStringUsingEncoding:NSUTF8StringEncoding] encoding:NSNonLossyASCIIStringEncoding];
        NSLog(@"\n🔷responseObject = %@",[NSString stringWithFormat:@"%@",responseUTFNonLossyASCIIStringEncoding]);
        id object = responseObject;
//        NSString *jsonString = [object JSONRepresentation];
//        if (jsonString) {
//            NSArray *shieldArray = [ShieldKeywordHelper shareInstance].data;
//            if (shieldArray) {
//                for (ShieldKeywordModel *model in shieldArray) {
//                    jsonString = [jsonString stringByReplacingOccurrencesOfString:model.name withString:@"***"];
//                }
//            }
//        }
//        object = [jsonString JSONValue];
        if(success)
            success(operationManager,object);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        if(failure)
            failure(operationManager, error);
        
        NSLog(@"error -------   %@",error);
        
    }];
    
    
    NSMutableArray *arrayRequest = nil;
    if (_muDicRequest[tag]) {
        arrayRequest = [NSMutableArray arrayWithArray:_muDicRequest[tag]];
    } else {
        arrayRequest = [NSMutableArray array];
    }
    [arrayRequest addObject:operationManager];
    [_muDicRequest setObject:arrayRequest forKey:tag];
    
    return operationManager;
}

//新的页面的请求

#pragma 取消正在发送的请求
- (void)cancelRequestOperationWithName:(NSString *)string
{
    for (AFHTTPSessionManager *operation in _muDicRequest[string]) {
        if (operation) {
            [AFHTTPSessionManager cancelPreviousPerformRequestsWithTarget:operation];
        }
    }
}

+ (void)cancelRequsting
{
    NSLog(@"cancelRequest");
    if ([NetWork shareNetwork].muDicRequest&&[NetWork shareNetwork].muDicRequest.allKeys.count) {
        NSString *requestTag = [[NetWork shareNetwork].muDicRequest.allKeys lastObject];
        NSLog(@"cancelRequst.tag = %@",requestTag);
        [[NetWork shareNetwork] cancelRequestOperationWithName:requestTag];
        [[NetWork shareNetwork].muDicRequest removeObjectForKey:requestTag];
    }
    
}

//请求完成后的处理
- (AFHTTPSessionManager *)handleRequestComplectionWithDic:(NSDictionary *)dic
                                                 isNewAPI:(BOOL)newAPI
                                                      Tag:(NSString *)tag
                                                ClassName:(NSString *)classname
                                            WaitAnimation:(BOOL)stop
                                               Completion:(RequestSuccessBlock)succession
                                                    Error:(RequestfaildBlock)failed
{
    return [sharedObj requestWithDic:dic isNewAPI:newAPI AndTag:tag success:^(AFHTTPSessionManager *operation,id Object) {
//        if ([_muDicRequest.allKeys containsObject:tag]) {
//            [_muDicRequest[tag] removeObject:operation];
//            if ([(NSArray *)_muDicRequest[tag] count] == 0) {
//                [_muDicRequest removeObjectForKey:tag];
//            }
//            NSLog(@"request = %@",_muDicRequest);
//            //等待控件是否消失处理
//            if (stop) {
////                [HYActivityIndicator stopActivityAnimation];
//            }
//            NSString *className = classname;
//            if (!classname) {
//                className = NSStringFromClass([BaseModel class]);
//            }
//            NSError *error = nil;
//            BaseModel *model = [[NSClassFromString(className) alloc] initWithDictionary:Object error:&error];
//            if (error) {
//                NSLog(@"💔💔解析时josnTo%@出错:%@💔💔", NSStringFromClass([BaseModel class]),error);
//            } else {
//                if ([model verifyResponseSuccess]) {//请求成功
//                    if (succession) {
//                        succession(model);
//                    }
//                } else {//请求失败
//                    if (failed) {
//                        failed(model);
//                    }
//                }
//            }
//        }
    } failure:^(AFHTTPSessionManager *operation, NSError *error) {
//        if ([_muDicRequest.allKeys containsObject:tag]) {
//            [_muDicRequest[tag] removeObject:operation];
//            if ([(NSArray *)_muDicRequest[tag] count] == 0) {
//                [_muDicRequest removeObjectForKey:tag];
//            }
//            //等待控件是否消失处理
//            if (stop) {
//                [HYActivityIndicator stopActivityAnimation];
//            }
//            //网络请求失败
//            BaseModel *model = [[BaseModel alloc] init];
//            model.info = @"网络连接失败";
//            model.result = 404;
//            if (failed) {
//                failed(model);
//            }
//        }
    }];
}

// //  后期统一添加参数 例如如 - userid和经纬度
- (AFHTTPSessionManager *)handleDefaultRequestComplectionWithDic:(NSDictionary *)dic
                                                        isNewAPI:(BOOL)newAPI
                                                             Tag:(NSString *)tag
                                                       ClassName:(NSString *)classname
                                                   WaitAnimation:(BOOL)stop
                                                      Completion:(RequestSuccessBlock)succession
                                                           Error:(RequestfaildBlock)failed
{
    return [self handleRequestComplectionWithDic:dic isNewAPI:newAPI Tag:tag ClassName:classname WaitAnimation:stop Completion:succession Error:failed];
}

//上传图片所使用的方法
- (AFHTTPSessionManager *)requestUpDateWithDic:(NSDictionary *)dic
                                      isNewAPI:(BOOL)newAPI
                                        AndTag:(NSString *)tag
                                 WaitAnimation:(BOOL)stop
                                       success:(void (^)(id object))success
                                       failure:(void (^)(NSURLSessionDataTask *operation, NSError *error))failure
{
    NSString *requestUrl = @""; //[NSString stringWithFormat:@"%@/%@",baseURL,tag];
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithDictionary:dic];
    NSLog(@"\u2665 \u2665 requestUrl = %@",requestUrl);
    NSLog(@"\u2665 \u2665 \u2665 \u2665 params = %@",dic);
    [dict removeObjectForKey:ImageKey];
    
    [self cancelRequestOperationWithName:tag];
    
    //1。创建管理者对象
    AFHTTPSessionManager *operation = [AFHTTPSessionManager manager];
    operation.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    //根据传入参数生成请求
    operation.requestSerializer = [AFJSONRequestSerializer serializer];
    [operation.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [operation.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    operation.responseSerializer.acceptableContentTypes = newAPI ? [NSSet setWithObject:@"application/json"] : [NSSet setWithObject:@"text/html"];
    
    
    //2.上传文件
    [operation POST:requestUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        if ([[dic objectForKey:ImageKey] isKindOfClass:[NSArray class]] || [[dic objectForKey:ImageKey] isKindOfClass:[NSMutableArray class]]) {
            int i = 0;
            for (UIImage *data in [dic objectForKey:ImageKey]) {
                float scale = 450 / data.size.width;
                CGSize size = CGSizeMake(450, scale*data.size.height);
                //                UIGraphicsBeginImageContext(size);
                UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
                // 绘制改变大小的图片
                [data drawInRect:CGRectMake(0, 0, size.width, size.height)];
                // 从当前context中创建一个改变大小后的图片
                UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                // 使当前的context出堆栈
                UIGraphicsEndImageContext();
                
                NSData* ret = UIImageJPEGRepresentation(scaledImage, 0.4);
                [formData appendPartWithFileData:ret name:[NSString stringWithFormat:@"%d",i] fileName:[NSString stringWithFormat:@"%d.jpg",i] mimeType:@".jpg"];
                i++;
            }
        }else if ([[dic objectForKey:ImageKey] isKindOfClass:[NSDictionary class]]){
            
            int i = 0;
            
            for (UIImage *data in [[dic objectForKey:ImageKey] allValues]) {
                float scale = 450 / data.size.width;
                CGSize size = CGSizeMake(450, scale*data.size.height);
                UIGraphicsBeginImageContextWithOptions(size, YES, [UIScreen mainScreen].scale);
                //                UIGraphicsBeginImageContext(size);
                // 绘制改变大小的图片
                [data drawInRect:CGRectMake(0, 0, size.width, size.height)];
                // 从当前context中创建一个改变大小后的图片
                UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
                // 使当前的context出堆栈
                UIGraphicsEndImageContext();
                
                NSData* ret = UIImageJPEGRepresentation(scaledImage, 0.4);
                
                NSString *imgName = [[dic objectForKey:ImageKey] allKeys][i];
                [formData appendPartWithFileData:ret name:imgName fileName:[NSString stringWithFormat:@"%@.jpg",imgName] mimeType:@".jpg"];
                i++;
            }
        }
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        //打印下上传进度
        NSLog(@"%lf",1.0 *uploadProgress.completedUnitCount / uploadProgress.totalUnitCount);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        //请求成功
        NSLog(@"\U0001F496 \U0001F496 \U0001F496 \U0001F496 responseObject = %@",responseObject);
        //取消等待控件
        if (stop) {
//            [HYActivityIndicator stopActivityAnimation];
        }
        id object = responseObject;
        if(success)
            success(object);
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        //请求失败
        //取消等待控件
        if (stop) {
//            [HYActivityIndicator stopActivityAnimation];
        }
        NSLog(@"\U0001F496 \U0001F496 \U0001F496 \U0001F496 error = %@",error);
        if(failure)
            failure(task, error);
    }];
    
  
    NSMutableArray *arrayRequest = nil;
    if (_muDicRequest[tag]) {
        arrayRequest = [NSMutableArray arrayWithArray:_muDicRequest[tag]];
    } else {
        arrayRequest = [NSMutableArray array];
    }
    [arrayRequest addObject:operation];
    [_muDicRequest setObject:arrayRequest forKey:tag];
    return operation;
}

//上传图片完成后的处理
- (AFHTTPSessionManager *)handleFormDataComplectionWithDic:(NSDictionary *)dic
                                                  isNewAPI:(BOOL)newAPI
                                                       Tag:(NSString *)tag
                                                  CustomID:(id)customId
                                                 ClassName:(NSString *)classname
                                             WaitAnimation:(BOOL)stop
                                                Completion:(RequestSuccessBlock)succession
                                                     Error:(RequestfaildBlock)failed
{
    return [sharedObj requestUpDateWithDic:dic isNewAPI:newAPI AndTag:[NSString stringWithFormat:@"%@",tag] WaitAnimation:stop success:^(id Object) {
//        //等待控件是否消失处理
//        if (stop) {
//            [HYActivityIndicator stopActivityAnimation];
//        }
//        NSString *className = classname;
//        if (!classname) {
//            className = NSStringFromClass([BaseModel class]);
//        }
//        NSError *error = nil;
//        BaseModel *model = [[NSClassFromString(className) alloc] initWithDictionary:Object error:&error];
//        if (error) {
//            PLog(@"💔💔解析时josnTo%@出错:%@💔💔", NSStringFromClass([BaseModel class]),error);
//        } else {
//            if ([model verifyResponseSuccess]) {//请求成功
//                if (succession) {
//                    succession(model);
//                }
//            } else {//请求失败
//                if (failed) {
//                    failed(model);
//                }
//            }
//        }
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        //等待控件是否消失处理
//        if (stop) {
//            [HYActivityIndicator stopActivityAnimation];
//        }
//        //网络请求失败
//        BaseModel *model = [[BaseModel alloc] init];
//        model.result = 404;
//        if (failed) {
//            failed(model);
//        }
    }];
}

#pragma mark - 方法具体实现

#pragma mark - 在参数字典中添加用户的userid和当前的经纬度
//- (NSMutableDictionary *)addUserIDAndLocationCoordinateIntoParamsDic:(NSDictionary *)dic
//{
//    //所有的接口皆加上用户id和经纬度
//    UserInfoCacheData *cacheData = [UserInfoCacheData cacheData];
//    NSMutableDictionary *mutDic = [NSMutableDictionary dictionaryWithDictionary:dic];
//    if ([UserDataHelper userid]) {
//        //        [dic setValue:[UserDataHelper userid] forKey:@"userid"];
//        [mutDic setObject:[UserDataHelper userid] forKey:@"userid"];
//    }else {
//        [mutDic setObject:@"0" forKey:@"userid"];
//    }
//    
//    NSString *latitude = [mutDic valueForKey:@"latitude"];
//    NSString *longitude = [mutDic valueForKey:@"longitude"];
//    
//    if (latitude && longitude && (![latitude isEqualToString:@""] && ![longitude isEqualToString:@""])) {
//        
//        [mutDic setObject:latitude forKey:@"latitude"];
//        [mutDic setObject:longitude forKey:@"longitude"];
//    }
//    if (!latitude.boolValue || !longitude.boolValue) {
//        
//        latitude = [NSString stringWithFormat:@"%g", cacheData.currentLocation.latitude];
//        longitude = [NSString stringWithFormat:@"%g", cacheData.currentLocation.longitude];
//        [mutDic setObject:latitude forKey:@"latitude"];
//        [mutDic setObject:longitude forKey:@"longitude"];
//        //        [cacheData startUpdatingUserLocation];
//    }
//    
//    return mutDic;
//}
/*-----------分类-------------*/



@end
